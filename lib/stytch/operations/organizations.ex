defmodule Stytch.Organizations do
  @moduledoc """
  Provides API endpoints related to organizations
  """

  @default_client Stytch.Client

  @doc """
  Create an Organization
  """
  @spec create(map, keyword) :: {:ok, any} | :error
  def create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Organizations, :create},
      url: "/v1/b2b/organizations",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Delete an Organization
  """
  @spec delete(String.t(), keyword) :: {:ok, any} | :error
  def delete(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Organizations, :delete},
      url: "/v1/b2b/organizations/#{organization_id}",
      method: :delete,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get an Organization
  """
  @spec get(String.t(), keyword) :: {:ok, any} | :error
  def get(organization_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id],
      call: {Stytch.Organizations, :get},
      url: "/v1/b2b/organizations/#{organization_id}",
      method: :get,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Search for Organizations
  """
  @spec search(map, keyword) :: {:ok, any} | :error
  def search(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Organizations, :search},
      url: "/v1/b2b/organizations/search",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update an Organization
  """
  @spec update(String.t(), map, keyword) :: {:ok, any} | :error
  def update(organization_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [organization_id: organization_id, body: body],
      call: {Stytch.Organizations, :update},
      url: "/v1/b2b/organizations/#{organization_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
