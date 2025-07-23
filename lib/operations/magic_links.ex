defmodule Stytch.MagicLinks do
  @moduledoc """
  Provides API endpoints related to magic links
  """

  @default_client Stytch.Client

  @type authenticate_200_json_resp :: %{
          intermediate_session_token: String.t(),
          member: Stytch.Member.t(),
          member_authenticated: boolean,
          member_id: String.t(),
          member_session: Stytch.Member.Session.t() | nil,
          method_id: String.t(),
          mfa_required: Stytch.MFARequired.t() | nil,
          organization: Stytch.Organization.t(),
          organization_id: String.t(),
          primary_required: Stytch.PrimaryRequired.t() | nil,
          request_id: String.t(),
          reset_sessions: boolean,
          session_jwt: String.t(),
          session_token: String.t(),
          status_code: integer
        }

  @doc """
  Authenticate Magic Link
  """
  @spec authenticate(body :: map, opts :: keyword) ::
          {:ok, Stytch.MagicLinks.authenticate_200_json_resp()} | {:error, Stytch.Error.t()}
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :authenticate},
      url: "/v1/b2b/magic_links/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.MagicLinks, :authenticate_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type authenticate_discovery_200_json_resp :: %{
          discovered_organizations: [Stytch.DiscoveredOrganization.t()],
          email_address: String.t(),
          intermediate_session_token: String.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Authenticate discovery Magic Link
  """
  @spec authenticate_discovery(body :: map, opts :: keyword) ::
          {:ok, Stytch.MagicLinks.authenticate_discovery_200_json_resp()}
          | {:error, Stytch.Error.t()}
  def authenticate_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :authenticate_discovery},
      url: "/v1/b2b/magic_links/discovery/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.MagicLinks, :authenticate_discovery_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type invite_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Send invite email
  """
  @spec invite(body :: map, opts :: keyword) ::
          {:ok, Stytch.MagicLinks.invite_200_json_resp()} | {:error, Stytch.Error.t()}
  def invite(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :invite},
      url: "/v1/b2b/magic_links/email/invite",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.MagicLinks, :invite_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type login_or_signup_200_json_resp :: %{
          member: Stytch.Member.t(),
          member_created: boolean,
          member_id: String.t(),
          organization: Stytch.Organization.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Send login or signup email
  """
  @spec login_or_signup(body :: map, opts :: keyword) ::
          {:ok, Stytch.MagicLinks.login_or_signup_200_json_resp()} | {:error, Stytch.Error.t()}
  def login_or_signup(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :login_or_signup},
      url: "/v1/b2b/magic_links/email/login_or_signup",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.MagicLinks, :login_or_signup_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @type send_discovery_200_json_resp :: %{request_id: String.t(), status_code: integer}

  @doc """
  Send discovery email
  """
  @spec send_discovery(body :: map, opts :: keyword) ::
          {:ok, Stytch.MagicLinks.send_discovery_200_json_resp()} | {:error, Stytch.Error.t()}
  def send_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :send_discovery},
      url: "/v1/b2b/magic_links/email/discovery/send",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {Stytch.MagicLinks, :send_discovery_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:authenticate_200_json_resp) do
    [
      intermediate_session_token: {:string, :generic},
      member: {Stytch.Member, :t},
      member_authenticated: :boolean,
      member_id: {:string, :generic},
      member_session: {Stytch.Member.Session, :t},
      method_id: {:string, :generic},
      mfa_required: {Stytch.MFARequired, :t},
      organization: {Stytch.Organization, :t},
      organization_id: {:string, :generic},
      primary_required: {Stytch.PrimaryRequired, :t},
      request_id: {:string, :generic},
      reset_sessions: :boolean,
      session_jwt: {:string, :generic},
      session_token: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:authenticate_discovery_200_json_resp) do
    [
      discovered_organizations: [{Stytch.DiscoveredOrganization, :t}],
      email_address: {:string, :generic},
      intermediate_session_token: {:string, :generic},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:invite_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:login_or_signup_200_json_resp) do
    [
      member: {Stytch.Member, :t},
      member_created: :boolean,
      member_id: {:string, :generic},
      organization: {Stytch.Organization, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:send_discovery_200_json_resp) do
    [request_id: {:string, :generic}, status_code: :integer]
  end
end
