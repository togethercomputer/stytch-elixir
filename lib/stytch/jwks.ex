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

  Use the special value `auth: false` to disable retrieval of the JWKS entirely. This can be
  useful in a testing environment where the default auth might be set.
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
         {:ok, kid} <- peek_kid(jwt),
         {:ok, jwk} <- select_jwk(jwks, kid, opts),
         {:ok, payload} <- verify_signature(jwt, jwk) do
      decode_payload(payload)
    end
  end

  @spec get_jwks(keyword) :: {:ok, %{String.t() => JOSE.JWK.t()}} | {:error, Exception.t()}
  def get_jwks(opts) do
    key_set_name = Keyword.get(opts, :name, __MODULE__)
    jwks = Application.get_env(:stytch, key_set_name)[:jwks]

    if is_map(jwks) do
      {:ok, jwks}
    else
      {:error, %RuntimeError{message: "No JWKs available for #{inspect(key_set_name)}"}}
    end
  end

  @spec peek_kid(String.t()) :: {:ok, String.t()} | {:error, Exception.t()}
  defp peek_kid(jwt) do
    case JOSE.JWT.peek_protected(jwt) do
      %JOSE.JWS{fields: %{"kid" => <<_::binary>> = kid}} when byte_size(kid) > 0 -> {:ok, kid}
      _ -> {:error, %RuntimeError{message: "Failed to extract key ID from JWT"}}
    end
  rescue
    _error -> {:error, %RuntimeError{message: "Failed to extract key ID from JWT"}}
  end

  @spec select_jwk(%{String.t() => JOSE.JWK.t()}, String.t(), keyword) ::
          {:ok, JOSE.JWK.t()} | {:error, Exception.t()}
  defp select_jwk(jwks, kid, opts) do
    if jwk = jwks[kid] do
      {:ok, jwk}
    else
      key_set_name = Keyword.get(opts, :name, __MODULE__)
      GenServer.call(key_set_name, {:fetch_jwk, kid})
    end
  end

  @spec verify_signature(String.t(), JOSE.JWK.t()) :: {:ok, binary} | {:error, Exception.t()}
  defp verify_signature(jwt, %JOSE.JWK{fields: %{"alg" => algorithm}} = jwk)
       when is_binary(algorithm) do
    case JOSE.JWS.verify_strict(jwk, [algorithm], jwt) do
      {true, payload, _header} -> {:ok, payload}
      _ -> {:error, %RuntimeError{message: "Failed to verify JWT with key #{jwk.fields["kid"]}"}}
    end
  rescue
    _error ->
      {:error, %RuntimeError{message: "Failed to verify JWT with key #{jwk.fields["kid"]}"}}
  end

  defp verify_signature(_jwt, %JOSE.JWK{fields: fields}) do
    {:error, %RuntimeError{message: "JWK #{fields["kid"]} is missing signing algorithm"}}
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

  @fetch_default_interval_ms :timer.hours(24)
  @fetch_minimum_interval_ms :timer.minutes(1)
  @fetch_per_key_interval_ms :timer.minutes(5)
  @cleanup_interval_ms :timer.hours(1)

  @typep state :: %{
           auth: {String.t(), String.t()} | nil,
           name: module,
           next_fetch_after: integer,
           project_id: String.t() | nil,
           unknown_kids_fetch_after: %{String.t() => integer}
         }

  @doc false
  @impl GenServer
  def init(opts) do
    state = new_state(opts)

    if state.project_id do
      Process.send_after(self(), :cleanup_unknown_ids, @cleanup_interval_ms)
      {:ok, state, {:continue, :fetch_jwks}}
    else
      Logger.info("Invalid project ID or secret for Stytch.JWKS; JWT verification unavailable")
      Application.put_env(:stytch, state.name, jwks: %{})
      :ignore
    end
  end

  @doc false
  @impl GenServer
  def handle_info(:fetch_jwks_interval, state) do
    {:noreply, state, {:continue, :fetch_jwks}}
  end

  def handle_info(:cleanup_unknown_ids, state) do
    {:noreply, cleanup_unknown_kids(state)}
  end

  @doc false
  @impl GenServer
  def handle_continue(:fetch_jwks, state) do
    next_fetch_after = :erlang.monotonic_time(:millisecond) + @fetch_minimum_interval_ms

    case do_fetch_jwks(state) do
      {:ok, _keys} ->
        Process.send_after(self(), :fetch_jwks_interval, @fetch_default_interval_ms)

      :error ->
        Process.send_after(self(), :fetch_jwks_interval, @fetch_minimum_interval_ms)
    end

    {:noreply, %{state | next_fetch_after: next_fetch_after}}
  end

  @doc false
  @impl GenServer
  def handle_call({:fetch_jwk, kid}, _from, state) do
    now = :erlang.monotonic_time(:millisecond)
    maybe_minimum_fetch_time = state.unknown_kids_fetch_after[kid]
    not_found_error = {:error, %RuntimeError{message: "No matching JWK found for key ID #{kid}"}}

    cond do
      maybe_minimum_fetch_time && now < maybe_minimum_fetch_time ->
        {:reply, not_found_error, state}

      now < state.next_fetch_after ->
        {:reply, not_found_error, state}

      :else ->
        case do_fetch_jwks(state) do
          {:ok, %{^kid => jwk}} ->
            {:reply, {:ok, jwk}, state}

          {:ok, _jwks} ->
            {:reply, not_found_error, track_unknown_kid(state, kid, now)}

          :error ->
            {:reply, not_found_error, state}
        end
    end
  end

  #
  # Unknown Key ID Management
  #

  @spec cleanup_unknown_kids(state) :: state
  defp cleanup_unknown_kids(state) do
    now = :erlang.monotonic_time(:millisecond)
    update = Map.reject(state.unknown_kids_fetch_after, fn {_kid, ts} -> now >= ts end)
    %{state | unknown_kids_fetch_after: update}
  end

  @spec track_unknown_kid(state, String.t(), pos_integer) :: state
  defp track_unknown_kid(state, kid, now) do
    update = Map.put(state.unknown_kids_fetch_after, kid, now + @fetch_per_key_interval_ms)
    %{state | unknown_kids_fetch_after: update}
  end

  #
  # Helpers
  #

  @spec do_fetch_jwks(state) :: {:ok, %{String.t() => JOSE.JWK.t()}} | :error
  defp do_fetch_jwks(%{auth: auth, project_id: project_id} = state) do
    case Stytch.Session.get_jwks(project_id, auth: auth) do
      {:ok, %{keys: keys}} ->
        keys = Map.new(keys, fn jwk -> {jwk.kid, decode_jwk(jwk)} end)
        Application.put_env(:stytch, state.name, jwks: keys)

        {:ok, keys}

      {:error, error} ->
        Logger.error("Failed to fetch JWKS: #{inspect(error)}")
        :error
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
    put_auth(
      %{
        auth: nil,
        name: opts[:name],
        next_fetch_after: :erlang.monotonic_time(:millisecond),
        project_id: nil,
        unknown_kids_fetch_after: %{}
      },
      opts[:auth]
    )
  end

  @spec put_auth(state, {String.t(), String.t()} | false | nil) :: state
  defp put_auth(state, false), do: state

  defp put_auth(state, nil) do
    case Application.get_env(:stytch, :default_auth) do
      nil ->
        state

      {"project-test-" <> _ = project_id, "secret-test-" <> _ = secret} ->
        Map.merge(state, %{auth: {project_id, secret}, project_id: project_id})

      {"project-live-" <> _ = project_id, "secret-live-" <> _ = secret} ->
        Map.merge(state, %{auth: {project_id, secret}, project_id: project_id})

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

  defp put_auth(state, {"project-test-" <> _ = project_id, "secret-test-" <> _ = secret}) do
    Map.merge(state, %{auth: {project_id, secret}, project_id: project_id})
  end

  defp put_auth(state, {"project-live-" <> _ = project_id, "secret-live-" <> _ = secret}) do
    Map.merge(state, %{auth: {project_id, secret}, project_id: project_id})
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
