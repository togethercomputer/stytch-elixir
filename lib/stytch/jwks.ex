defmodule Stytch.JWKS do
  @moduledoc """
  Provides functions for working with JSON Web Key Sets (JWKS) used for verifying JWTs
  (JSON Web Tokens)

  JWTs are one way to identify sessions with Stytch. This module allows you to decode and verify
  JWTs and manages the JSON Web Key Set (JWKS) used for verification.

  ## Usage

  Stytch provides a JWKS endpoint that contains the public keys used to verify JWTs. These keys
  rotate periodically, so it's important to fetch the JWKS regularly and cache it. Include this
  module in your application supervision tree to automatically fetch and cache the JWKS.

      defmodule MyApp.Application do
        use Application

        def start(_type, _args) do
          children = [
            Stytch.JWKS
          ]

          opts = [strategy: :one_for_one, name: MyApp.Supervisor]
          Supervisor.start_link(children, opts)
        end
      end

  If you need support for multiple projects, you can start multiple instances with different
  process names:

      children = [
        {Stytch.JWKS, name: MyApp.JWKS1, auth: {"project1_id", "secret1"}},
        {Stytch.JWKS, name: MyApp.JWKS2, auth: {"project2_id", "secret2"}}
      ]

  ## Configuration

  JWKS provided by Stytch are project-dependent. By default, this module uses the Project ID and
  secret from the default auth:

      config :stytch,
        default_auth: {System.fetch_env!("STYTCH_PROJECT_ID"), System.fetch_env!("STYTCH_SECRET")}

  If you need to modify the project ID or secret, you can pass them as options when starting the
  GenServer:

      Stytch.JWKS.start_link(auth: {"your_project_id", "your_secret"})

  Or, in your main application supervisor:

      children = [
        {Stytch.JWKS, auth: {"your_project_id", "your_secret"}}
      ]

  """
  use GenServer
  require Logger

  #
  # Public API
  #

  @doc false
  @spec start_link(opts :: keyword) :: Supervisor.on_start()
  def start_link(opts \\ []) do
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, opts, name: opts[:name])
  end

  @doc """
  Verifies a signed JWT using the key set managed by this module

  Returns the payload of the signed JWT if successful, or an error if there is no matching key.
  It is the caller's responsibility to check the expiration time (`exp` in the payload).

  ## Options

    * `name`: The name of the key set to use (defaults to `Stytch.JWKS`)

  """
  @spec verify(String.t(), keyword) :: {:ok, map} | {:error, Exception.t()}
  def verify(jwt, opts \\ []) do
    with {:ok, jwks} <- get_jwks(opts),
         {:ok, payload} <- verify_signature(jwks, jwt) do
      decode_payload(payload)
    end
  end

  @spec get_jwks(keyword) :: {:ok, [JOSE.JWK.t()]} | {:error, Exception.t()}
  def get_jwks(opts) do
    key_set_name = Keyword.get(opts, :name, __MODULE__)
    jwks = Application.get_env(:stytch, key_set_name)[:jwks]

    if is_list(jwks) and length(jwks) > 0 do
      {:ok, jwks}
    else
      {:error, %RuntimeError{message: "No JWKs available for #{inspect(key_set_name)}"}}
    end
  end

  @spec verify_signature([JOSE.JWK.t()], String.t()) :: {:ok, binary} | {:error, Exception.t()}
  defp verify_signature(jwks, jwt) do
    Enum.find_value(jwks, {:error, %RuntimeError{message: "Failed to verify JWT"}}, fn jwk ->
      %JOSE.JWK{fields: %{"alg" => algorithm}} = jwk

      case JOSE.JWS.verify_strict(jwk, [algorithm], jwt) do
        {true, payload, _header} -> {:ok, payload}
        _ -> nil
      end
    end)
  end

  @spec decode_payload(binary) :: {:ok, map} | {:error, Exception.t()}
  defp decode_payload(payload) do
    case JSON.decode(payload) do
      {:ok, decoded} ->
        {:ok, decoded}

      {:error, reason} ->
        {:error, %RuntimeError{message: "Failed to decode JWT payload: #{inspect(reason)}"}}
    end
  end

  #
  # Server
  #

  @fetch_interval_ms 24 * 60 * 60 * 1000
  @fetch_retry_interval_ms 60 * 1000

  @typep state :: %{
           name: module,
           project_id: String.t() | nil,
           secret: String.t() | nil,
           jwks: [Stytch.JWK.t()]
         }

  @doc false
  @spec init(keyword) :: {:ok, state, {:continue, :fetch_jwks}} | {:stop, Exception.t()}
  def init(opts) do
    state = new_state(opts)

    if state.project_id && state.secret do
      {:ok, state, {:continue, :fetch_jwks}}
    else
      Logger.info("Invalid project ID or secret for Stytch.JWKS; JWT verification unavailable")
      Application.put_env(:stytch, state.name, jwks: [])
      :ignore
    end
  end

  @doc false
  @spec handle_continue(:fetch_jwks, state) :: {:noreply, state}
  def handle_continue(:fetch_jwks, state) do
    do_fetch_jwks(state)
  end

  @doc false
  @spec handle_info(:fetch_jwks, state) :: {:noreply, state}
  def handle_info(:fetch_jwks, state) do
    do_fetch_jwks(state)
  end

  #
  # Helpers
  #

  @spec do_fetch_jwks(state) :: {:noreply, state}
  defp do_fetch_jwks(%{project_id: project_id, secret: secret} = state) do
    case Stytch.Session.get_jwks(project_id, auth: {project_id, secret}) do
      {:ok, %{keys: keys}} ->
        Process.send_after(self(), :fetch_jwks, @fetch_interval_ms)

        keys = Enum.map(keys, &decode_jwk/1)
        Application.put_env(:stytch, state.name, jwks: keys)

        {:noreply, Map.put(state, :jwks, keys)}

      {:error, error} ->
        Process.send_after(self(), :fetch_jwks, @fetch_retry_interval_ms)
        Logger.error("Failed to fetch JWKS: #{inspect(error)}")
        {:noreply, state}
    end
  end

  @spec decode_jwk(Stytch.JWK.t()) :: JOSE.JWK.t()
  defp decode_jwk(stytch_jwk) do
    stytch_jwk
    |> Map.from_struct()
    |> Map.new(fn {k, v} -> {to_string(k), v} end)
    |> JOSE.JWK.from()
  end

  @spec new_state(keyword) :: state
  defp new_state(opts) do
    put_auth(%{name: opts[:name], project_id: nil, secret: nil, jwks: []}, opts[:auth])
  end

  @spec put_auth(state, {String.t(), String.t()} | nil) :: state
  defp put_auth(state, nil) do
    case Application.get_env(:stytch, :default_auth) do
      nil ->
        state

      {"project-test-" <> _ = project_id, "secret-test-" <> _ = secret} ->
        Map.merge(state, %{project_id: project_id, secret: secret})

      {"project-live-" <> _ = project_id, "secret-live-" <> _ = secret} ->
        Map.merge(state, %{project_id: project_id, secret: secret})

      _else ->
        Logger.warning("""
        Invalid default auth configuration for Stytch.

        Expected:

          config :stytch, :default_auth,
            {
              "project-test-...",
              "secret-test-..."
            }

        or

          config :stytch, :default_auth,
            {
              "project-live-...",
              "secret-live-..."
            }

        Please check the configuration.
        """)

        state
    end
  end

  defp put_auth(
         state,
         {"project-test-" <> _ = project_id, "secret-test-" <> _ = secret}
       ) do
    Map.merge(state, %{project_id: project_id, secret: secret})
  end

  defp put_auth(
         state,
         {"project-live-" <> _ = project_id, "secret-live-" <> _ = secret}
       ) do
    Map.merge(state, %{project_id: project_id, secret: secret})
  end

  defp put_auth(state, _) do
    Logger.warning("""
    Invalid auth configuration for Stytch.JWKS.

    Expected:

      {
        "project-test-...",
        "secret-test-..."
      }

    or

      {
        "project-live-...",
        "secret-live-..."
      }

    Please check the configuration.
    """)

    state
  end
end
