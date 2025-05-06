defmodule Stytch.Discovery do
  @moduledoc """
  Provides API endpoints related to discovery
  """

  @default_client Stytch.Client

  @doc """
  Create Organization via Discovery
  """
  @spec create_organization(map, keyword) :: {:ok, any} | :error
  def create_organization(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Discovery, :create_organization},
      url: "/v1/b2b/discovery/organizations/create",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Exchange intermediate session
  """
  @spec exchange_intermediate_session(map, keyword) :: {:ok, any} | :error
  def exchange_intermediate_session(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Discovery, :exchange_intermediate_session},
      url: "/v1/b2b/discovery/intermediate_sessions/exchange",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  List discovered Organizations
  """
  @spec list(map, keyword) :: {:ok, any} | :error
  def list(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Discovery, :list},
      url: "/v1/b2b/discovery/organizations",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
