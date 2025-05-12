defmodule Stytch.Sso do
  @moduledoc """
  Provides API endpoints related to sso
  """

  @default_client Stytch.Client

  @type complete_200_json_resp :: %{
          intermediate_session_token: String.t(),
          member: Stytch.Member.t(),
          member_authenticated: boolean,
          member_id: String.t(),
          member_session: Stytch.Member.Session.t() | nil,
          mfa_required: boolean | nil,
          organization: Stytch.Organization.t(),
          organization_id: String.t(),
          request_id: String.t(),
          reset_session: boolean,
          session_jwt: String.t(),
          session_token: String.t(),
          status_code: integer
        }

  @doc """
  Complete SSO Authentication
  """
  @spec complete(body :: map, opts :: keyword) :: {:ok, map} | :error
  def complete(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Sso, :complete},
      url: "/v1/b2b/sso/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :complete_200_json_resp}}],
      opts: opts
    })
  end

  @type create_external_connection_200_json_resp :: %{
          connection: Stytch.Connection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Create External Connection
  """
  @spec create_external_connection(organization_id :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | :error
  def create_external_connection(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Sso, :create_external_connection},
      url: "/v1/b2b/sso/external/#{organization_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :create_external_connection_200_json_resp}}],
      opts: opts
    })
  end

  @type create_oidc_200_json_resp :: %{
          connection: Stytch.OIDCConnection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Create OIDC Connection
  """
  @spec create_oidc(organization_id :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | :error
  def create_oidc(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Sso, :create_oidc},
      url: "/v1/b2b/sso/oidc/#{organization_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :create_oidc_200_json_resp}}],
      opts: opts
    })
  end

  @type create_saml_200_json_resp :: %{
          connection: Stytch.SAMLConnection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Create SAML Connection
  """
  @spec create_saml(organization_id :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | :error
  def create_saml(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Sso, :create_saml},
      url: "/v1/b2b/sso/saml/#{organization_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :create_saml_200_json_resp}}],
      opts: opts
    })
  end

  @type delete_connection_200_json_resp :: %{
          connection_id: String.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete SSO Connection
  """
  @spec delete_connection(
          organization_id :: String.t(),
          connection_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def delete_connection(organization_id, connection_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id],
      call: {Stytch.Sso, :delete_connection},
      url: "/v1/b2b/sso/#{organization_id}/connections/#{connection_id}",
      method: :delete,
      response: [{200, {Stytch.Sso, :delete_connection_200_json_resp}}],
      opts: opts
    })
  end

  @type delete_saml_verification_certificate_200_json_resp :: %{
          connection: Stytch.SAMLConnection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Delete SAML Verification Certificate
  """
  @spec delete_saml_verification_certificate(
          organization_id :: String.t(),
          connection_id :: String.t(),
          certificate_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def delete_saml_verification_certificate(
        organization_id,
        connection_id,
        certificate_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        organization_id: organization_id,
        connection_id: connection_id,
        certificate_id: certificate_id
      ],
      call: {Stytch.Sso, :delete_saml_verification_certificate},
      url:
        "/v1/b2b/sso/saml/#{organization_id}/connections/#{connection_id}/verification_certificates/#{certificate_id}",
      method: :delete,
      response: [{200, {Stytch.Sso, :delete_saml_verification_certificate_200_json_resp}}],
      opts: opts
    })
  end

  @type get_connections_200_json_resp :: %{
          external_connections: [Stytch.Connection.t()],
          oidc_connections: [Stytch.OIDCConnection.t()],
          request_id: String.t(),
          saml_connections: [Stytch.SAMLConnection.t()],
          status_code: integer
        }

  @doc """
  Get SSO Connections
  """
  @spec get_connections(organization_id :: String.t(), opts :: keyword) :: {:ok, map} | :error
  def get_connections(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Sso, :get_connections},
      url: "/v1/b2b/sso/#{organization_id}",
      method: :get,
      response: [{200, {Stytch.Sso, :get_connections_200_json_resp}}],
      opts: opts
    })
  end

  @type get_oidc_access_token_200_json_resp :: %{
          registrations: [Stytch.OIDCProviderInfo.t()] | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  @doc """
  Get OIDC Access Token

  ## Options

    * `include_refresh_token`

  """
  @spec get_oidc_access_token(
          organization_id :: String.t(),
          member_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def get_oidc_access_token(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:include_refresh_token])

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Sso, :get_oidc_access_token},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}/oidc_providers",
      method: :get,
      query: query,
      response: [{200, {Stytch.Sso, :get_oidc_access_token_200_json_resp}}],
      opts: opts
    })
  end

  @type start_200_json_resp :: %{
          redirect_url: String.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Start SSO Authentication

  ## Options

    * `connection_id`
    * `public_token`

  """
  @spec start(opts :: keyword) :: {:ok, map} | :error
  def start(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:connection_id, :public_token])

    client.request(%{
      args: [],
      call: {Stytch.Sso, :start},
      url: "/v1/public/sso/start",
      method: :get,
      query: query,
      response: [{200, {Stytch.Sso, :start_200_json_resp}}],
      opts: opts
    })
  end

  @type update_external_connection_200_json_resp :: %{
          connection: Stytch.Connection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Update External Connection
  """
  @spec update_external_connection(
          organization_id :: String.t(),
          connection_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def update_external_connection(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_external_connection},
      url: "/v1/b2b/sso/external/#{organization_id}/connections/#{connection_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :update_external_connection_200_json_resp}}],
      opts: opts
    })
  end

  @type update_oidc_200_json_resp :: %{
          connection: Stytch.OIDCConnection.t(),
          request_id: String.t(),
          status_code: integer,
          warning: String.t()
        }

  @doc """
  Update OIDC Connection
  """
  @spec update_oidc(
          organization_id :: String.t(),
          connection_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def update_oidc(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_oidc},
      url: "/v1/b2b/sso/oidc/#{organization_id}/connections/#{connection_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :update_oidc_200_json_resp}}],
      opts: opts
    })
  end

  @type update_saml_200_json_resp :: %{
          connection: Stytch.SAMLConnection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Update SAML Connection
  """
  @spec update_saml(
          organization_id :: String.t(),
          connection_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def update_saml(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_saml},
      url: "/v1/b2b/sso/saml/#{organization_id}/connections/#{connection_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :update_saml_200_json_resp}}],
      opts: opts
    })
  end

  @type update_saml_by_metadata_url_200_json_resp :: %{
          connection: Stytch.SAMLConnection.t(),
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Update SAML Connection by metadata URL
  """
  @spec update_saml_by_metadata_url(
          organization_id :: String.t(),
          connection_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def update_saml_by_metadata_url(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_saml_by_metadata_url},
      url: "/v1/b2b/sso/saml/#{organization_id}/connections/#{connection_id}/url",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Stytch.Sso, :update_saml_by_metadata_url_200_json_resp}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:complete_200_json_resp) do
    [
      intermediate_session_token: {:string, :generic},
      member: {Stytch.Member, :t},
      member_authenticated: :boolean,
      member_id: {:string, :generic},
      member_session: {Stytch.Member.Session, :t},
      mfa_required: :boolean,
      organization: {Stytch.Organization, :t},
      organization_id: {:string, :generic},
      request_id: {:string, :generic},
      reset_session: :boolean,
      session_jwt: {:string, :generic},
      session_token: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:create_external_connection_200_json_resp) do
    [connection: {Stytch.Connection, :t}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:create_oidc_200_json_resp) do
    [
      connection: {Stytch.OIDCConnection, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:create_saml_200_json_resp) do
    [
      connection: {Stytch.SAMLConnection, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:delete_connection_200_json_resp) do
    [connection_id: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:delete_saml_verification_certificate_200_json_resp) do
    [
      connection: {Stytch.SAMLConnection, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:get_connections_200_json_resp) do
    [
      external_connections: [{Stytch.Connection, :t}],
      oidc_connections: [{Stytch.OIDCConnection, :t}],
      request_id: {:string, :generic},
      saml_connections: [{Stytch.SAMLConnection, :t}],
      status_code: :integer
    ]
  end

  def __fields__(:get_oidc_access_token_200_json_resp) do
    [
      registrations: [{Stytch.OIDCProviderInfo, :t}],
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:start_200_json_resp) do
    [redirect_url: {:string, :generic}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:update_external_connection_200_json_resp) do
    [connection: {Stytch.Connection, :t}, request_id: {:string, :generic}, status_code: :integer]
  end

  def __fields__(:update_oidc_200_json_resp) do
    [
      connection: {Stytch.OIDCConnection, :t},
      request_id: {:string, :generic},
      status_code: :integer,
      warning: {:string, :generic}
    ]
  end

  def __fields__(:update_saml_200_json_resp) do
    [
      connection: {Stytch.SAMLConnection, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end

  def __fields__(:update_saml_by_metadata_url_200_json_resp) do
    [
      connection: {Stytch.SAMLConnection, :t},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end
end
