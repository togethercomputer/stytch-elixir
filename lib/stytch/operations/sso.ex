defmodule Stytch.Sso do
  @moduledoc """
  Provides API endpoints related to sso
  """

  @default_client Stytch.Client

  @doc """
  Complete SSO Authentication
  """
  @spec complete(map, keyword) :: {:ok, any} | :error
  def complete(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Sso, :complete},
      url: "/v1/b2b/sso/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Create External Connection
  """
  @spec create_external_connection(String.t(), map, keyword) :: {:ok, any} | :error
  def create_external_connection(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Sso, :create_external_connection},
      url: "/v1/b2b/sso/external/#{organization_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Create OIDC Connection
  """
  @spec create_oidc(String.t(), map, keyword) :: {:ok, any} | :error
  def create_oidc(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Sso, :create_oidc},
      url: "/v1/b2b/sso/oidc/#{organization_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Create SAML Connection
  """
  @spec create_saml(String.t(), map, keyword) :: {:ok, any} | :error
  def create_saml(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Sso, :create_saml},
      url: "/v1/b2b/sso/saml/#{organization_id}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Delete SSO Connection
  """
  @spec delete_connection(String.t(), String.t(), keyword) :: {:ok, any} | :error
  def delete_connection(organization_id, connection_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id],
      call: {Stytch.Sso, :delete_connection},
      url: "/v1/b2b/sso/#{organization_id}/connections/#{connection_id}",
      method: :delete,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Delete SAML Verification Certificate
  """
  @spec delete_saml_verification_certificate(String.t(), String.t(), String.t(), keyword) ::
          {:ok, any} | :error
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
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get SSO Connections
  """
  @spec get_connections(String.t(), keyword) :: {:ok, any} | :error
  def get_connections(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Sso, :get_connections},
      url: "/v1/b2b/sso/#{organization_id}",
      method: :get,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Start SSO Authentication

  ## Options

    * `connection_id`
    * `public_token`

  """
  @spec start(keyword) :: {:ok, any} | :error
  def start(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:connection_id, :public_token])

    client.request(%{
      args: [],
      call: {Stytch.Sso, :start},
      url: "/v1/public/sso/start",
      method: :get,
      query: query,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update External Connection
  """
  @spec update_external_connection(String.t(), String.t(), map, keyword) :: {:ok, any} | :error
  def update_external_connection(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_external_connection},
      url: "/v1/b2b/sso/external/#{organization_id}/connections/#{connection_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update OIDC Connection
  """
  @spec update_oidc(String.t(), String.t(), map, keyword) :: {:ok, any} | :error
  def update_oidc(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_oidc},
      url: "/v1/b2b/sso/oidc/#{organization_id}/connections/#{connection_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update SAML Connection
  """
  @spec update_saml(String.t(), String.t(), map, keyword) :: {:ok, any} | :error
  def update_saml(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_saml},
      url: "/v1/b2b/sso/saml/#{organization_id}/connections/#{connection_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update SAML Connection by metadata URL
  """
  @spec update_saml_by_metadata_url(String.t(), String.t(), map, keyword) :: {:ok, any} | :error
  def update_saml_by_metadata_url(organization_id, connection_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, connection_id: connection_id, body: body],
      call: {Stytch.Sso, :update_saml_by_metadata_url},
      url: "/v1/b2b/sso/saml/#{organization_id}/connections/#{connection_id}/url",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
