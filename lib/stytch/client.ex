defmodule Stytch.Client do
  @moduledoc """
  Implements HTTP calls to the Stytch API using Req
  """
  require Logger

  @spec request(map) :: any
  def request(details) do
    Req.new(method: details.method, url: details.url)
    |> put_auth_and_base_url(details.opts[:auth])
    |> put_body(details.body)
    |> put_req_opts(details.opts[:req_opts])
    |> put_telemetry(details.call)
    |> Req.request()
    |> handle_response(details)
  end

  @spec handle_response({:ok, Req.Response.t()}, map) :: {:ok, term} | {:error | term}
  @spec handle_response({:error, Exception.t()}, map) :: {:error, term}
  defp handle_response({:ok, %Req.Response{} = response}, details) do
    case response do
      %Req.Response{body: body, status: s} when s in 200..299 ->
        {:ok, Stytch.Decoder.decode_response(body, details, s)}

      %Req.Response{body: body, status: status} ->
        {:current_stacktrace, stack} = Process.info(self(), :current_stacktrace)
        # Drop `Process.info/2`, `handle_response/1`, and `request/1`.
        stacktrace = Enum.drop(stack, 3)

        fields =
          Keyword.merge(
            [
              code: status,
              message: "Unknown Error",
              operation: details.call,
              reason: :error,
              source: body,
              stacktrace: stacktrace
            ],
            extract_error(body)
          )

        {:error, struct!(%Stytch.Error{}, fields)}
    end
  end

  defp handle_response({:error, error}, details) do
    {:current_stacktrace, stack} = Process.info(self(), :current_stacktrace)
    # Drop `Process.info/2`, `handle_response/1`, and `request/1`.
    stacktrace = Enum.drop(stack, 3)

    fields =
      [
        code: nil,
        message: "Unknown Error",
        operation: details.call,
        reason: :error,
        source: error,
        stacktrace: stacktrace
      ]

    {:error, struct!(%Stytch.Error{}, fields)}
  end

  @spec extract_error(term) :: keyword
  defp extract_error(%{"error_message" => error_message} = body) do
    [
      message: error_message,
      source: Stytch.Decoder.decode_direct(body, {Stytch.ErrorResponse, :t})
    ]
  end

  @spec put_auth_and_base_url(Req.Request.t(), {String.t(), String.t()} | nil) :: Req.Request.t()
  defp put_auth_and_base_url(req, nil) do
    opts =
      case Application.get_env(:stytch, :default_auth) do
        nil ->
          [base_url: "https://test.stytch.com"]

        {"project-test-" <> _ = project_id, "secret-test-" <> _ = secret} ->
          [base_url: "https://test.stytch.com", auth: {:basic, "#{project_id}:#{secret}"}]

        {"project-live-" <> _ = project_id, "secret-live-" <> _ = secret} ->
          [base_url: "https://api.stytch.com", auth: {:basic, "#{project_id}:#{secret}"}]

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

          [base_url: "https://test.stytch.com"]
      end

    Req.merge(req, opts)
  end

  defp put_auth_and_base_url(
         req,
         {"project-test-" <> _ = project_id, "secret-test-" <> _ = secret}
       ) do
    Req.merge(req,
      base_url: "https://test.stytch.com",
      auth: {:basic, "#{project_id}:#{secret}"}
    )
  end

  defp put_auth_and_base_url(
         req,
         {"project-live-" <> _ = project_id, "secret-live-" <> _ = secret}
       ) do
    Req.merge(req,
      base_url: "https://api.stytch.com",
      auth: {:basic, "#{project_id}:#{secret}"}
    )
  end

  defp put_auth_and_base_url(req, _) do
    Logger.warning("""
    Invalid auth configuration for Stytch.

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

    Req.merge(req, base_url: "https://test.stytch.com")
  end

  @spec put_body(Req.Request.t(), map | nil) :: Req.Request.t()
  defp put_body(req, nil), do: req
  defp put_body(req, body), do: Req.merge(req, json: body)

  @spec put_req_opts(Req.Request.t(), keyword | nil) :: Req.Request.t()
  defp put_req_opts(request, nil) do
    req_opts = Application.get_env(:stytch, :req_opts) || []
    Req.merge(request, req_opts)
  end

  defp put_req_opts(request, req_opts) do
    Req.merge(request, req_opts)
  end

  @spec put_telemetry(Req.Request.t(), {module, atom}) :: Req.Request.t()
  defp put_telemetry(req, {module, function}) do
    call = "#{module}.#{function}"
    ReqTelemetry.attach(req, metadata: %{call: call})
  end
end
