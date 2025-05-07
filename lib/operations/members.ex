defmodule Stytch.Members do
  @moduledoc """
  Provides API endpoints related to members
  """

  @default_client Stytch.Client

  @doc """
  Create a Member
  """
  @spec create(organization_id :: String.t(), body :: map, opts :: keyword) :: {:ok, map} | :error
  def create(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Members, :create},
      url: "/v1/b2b/organizations/#{organization_id}/members",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Get a Member (Dangerous)
  """
  @spec dangerously_get(member_id :: String.t(), opts :: keyword) :: {:ok, map} | :error
  def dangerously_get(member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [member_id: member_id],
      call: {Stytch.Members, :dangerously_get},
      url: "/v1/b2b/organizations/members/dangerously_get/#{member_id}",
      method: :get,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Delete a Member
  """
  @spec delete(organization_id :: String.t(), member_id :: String.t(), opts :: keyword) ::
          {:ok, map} | :error
  def delete(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :delete},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}",
      method: :delete,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Delete Member MFA phone number
  """
  @spec delete_mfa_phone_number(
          organization_id :: String.t(),
          member_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def delete_mfa_phone_number(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :delete_mfa_phone_number},
      url: "/v1/b2b/organizations/#{organization_id}/members/mfa_phone_numbers/#{member_id}",
      method: :delete,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Delete Member password
  """
  @spec delete_password(
          organization_id :: String.t(),
          member_password_id :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | :error
  def delete_password(organization_id, member_password_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_password_id: member_password_id],
      call: {Stytch.Members, :delete_password},
      url: "/v1/b2b/organizations/#{organization_id}/members/passwords/#{member_password_id}",
      method: :delete,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Get a Member

  ## Options

    * `member_id`: Get member by ID

  """
  @spec get(organization_id :: String.t(), opts :: keyword) :: {:ok, map} | :error
  def get(organization_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:member_id])

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Members, :get},
      url: "/v1/b2b/organizations/#{organization_id}/member",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Reactivate a Member
  """
  @spec reactivate(organization_id :: String.t(), member_id :: String.t(), opts :: keyword) ::
          {:ok, map} | :error
  def reactivate(organization_id, member_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id],
      call: {Stytch.Members, :reactivate},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}/reactivate",
      method: :put,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Search for Members
  """
  @spec search(body :: map, opts :: keyword) :: {:ok, map} | :error
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Members, :search},
      url: "/v1/b2b/organizations/members/search",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Update a Member
  """
  @spec update(
          organization_id :: String.t(),
          member_id :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | :error
  def update(organization_id, member_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, member_id: member_id, body: body],
      call: {Stytch.Members, :update},
      url: "/v1/b2b/organizations/#{organization_id}/members/#{member_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end
end
