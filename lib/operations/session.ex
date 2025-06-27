defmodule Stytch.Session do
  @moduledoc """
  Provides API endpoints related to session
  """

  @default_client Stytch.Client

  @type authenticate_200_json_resp :: %{
          authorized: boolean,
          member: Stytch.Member.t(),
          member_session: Stytch.Member.Session.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          session_jwt: String.t(),
          session_token: String.t(),
          status_code: integer,
          verdict: [String.t()]
        }

  @doc """
  Authenticate Session
  """
  @spec authenticate(body :: map, opts :: keyword) ::
          {:ok, Stytch.Session.authenticate_200_json_resp()} | {:error, Stytch.Error.t()}
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :authenticate},
      url: "/v1/b2b/sessions/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Session, :authenticate_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type exchange_200_json_resp :: %{
          intermediate_session_token: String.t(),
          member: Stytch.Member.t(),
          member_authenticated: boolean,
          member_id: String.t(),
          member_session: Stytch.Member.Session.t(),
          mfa_required: boolean,
          organization: Stytch.Organization.t(),
          primary_required: boolean,
          request_id: String.t(),
          session_jwt: String.t(),
          session_token: String.t(),
          status_code: integer
        }

  @doc """
  Exchange session
  """
  @spec exchange(body :: map, opts :: keyword) ::
          {:ok, Stytch.Session.exchange_200_json_resp()} | {:error, Stytch.Error.t()}
  def exchange(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :exchange},
      url: "/v1/b2b/sessions/exchange",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Session, :exchange_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type get_200_json_resp :: %{
          member_sessions: [Stytch.Member.Session.t()],
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Get Session

  ## Options

    * `organization_id`
    * `member_id`

  """
  @spec get(opts :: keyword) ::
          {:ok, Stytch.Session.get_200_json_resp()} | {:error, Stytch.Error.t()}
  def get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:member_id, :organization_id])

    client.request(%{
      args: [],
      call: {Stytch.Session, :get},
      url: "/v1/b2b/sessions",
      method: :get,
      query: query,
      response: [{200, {Stytch.Session, :get_200_json_resp}}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @type get_jwks_200_json_resp :: %{
          keys: [Stytch.JWK.t()],
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Get JWKs
  """
  @spec get_jwks(project_id :: String.t(), opts :: keyword) ::
          {:ok, Stytch.Session.get_jwks_200_json_resp()} | {:error, Stytch.Error.t()}
  def get_jwks(project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id],
      call: {Stytch.Session, :get_jwks},
      url: "/v1/b2b/sessions/jwks/#{project_id}",
      method: :get,
      response: [
        {200, {Stytch.Session, :get_jwks_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type migrate_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_session: Stytch.Member.Session.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          session_jwt: String.t(),
          session_token: String.t(),
          status_code: integer
        }

  @doc """
  Migrate Session
  """
  @spec migrate(body :: map, opts :: keyword) ::
          {:ok, Stytch.Session.migrate_200_json_resp()} | {:error, Stytch.Error.t()}
  def migrate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :migrate},
      url: "/v1/b2b/sessions/migrate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Session, :migrate_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type revoke_200_json_resp :: %{request_id: String.t(), status_code: integer}

  @doc """
  Revoke Session
  """
  @spec revoke(body :: map, opts :: keyword) ::
          {:ok, Stytch.Session.revoke_200_json_resp()} | {:error, Stytch.Error.t()}
  def revoke(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :revoke},
      url: "/v1/b2b/sessions/revoke",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.Session, :revoke_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:authenticate_200_json_resp) do
    [
      authorized: :boolean,
      member: {Stytch.Member, :t},
      member_session: {Stytch.Member.Session, :t},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      session_jwt: {:string, :generic},
      session_token: {:string, :generic},
      status_code: :integer,
      verdict: [string: :generic]
    ]
  end

  def __fields__(:exchange_200_json_resp) do
    [
      intermediate_session_token: {:string, :generic},
      member: {Stytch.Member, :t},
      member_authenticated: :boolean,
      member_id: {:string, :generic},
      member_session: {Stytch.Member.Session, :t},
      mfa_required: :boolean,
      organization: {Stytch.Organization, :t},
      primary_required: :boolean,
      request_id: {:string, :generic},
      session_jwt: {:string, :generic},
      session_token: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:get_200_json_resp) do
    [
      member_sessions: [{Stytch.Member.Session, :t}],
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:get_jwks_200_json_resp) do
    [keys: [{Stytch.JWK, :t}], request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:migrate_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_session: {Stytch.Member.Session, :t},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      session_jwt: {:string, :generic},
      session_token: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:revoke_200_json_resp) do
    [request_id: {:string, :generic}, status_code: :integer]
  end
end
