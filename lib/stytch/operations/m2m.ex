defmodule Stytch.M2M do
  @moduledoc """
  Provides API endpoints related to m2 m
  """

  @default_client Stytch.Client

  @doc """
  Cancel secret rotation
  """
  @spec cancel_secret_rotation(String.t(), keyword) :: {:ok, any} | :error
  def cancel_secret_rotation(client_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id],
      call: {Stytch.M2M, :cancel_secret_rotation},
      url: "/v1/m2m/clients/#{client_id}/secrets/rotate/cancel",
      method: :post,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Create M2M client
  """
  @spec create_client(map, keyword) :: {:ok, any} | :error
  def create_client(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.M2M, :create_client},
      url: "/v1/m2m/clients",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Delete M2M client
  """
  @spec delete_client(String.t(), keyword) :: {:ok, any} | :error
  def delete_client(client_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id],
      call: {Stytch.M2M, :delete_client},
      url: "/v1/m2m/clients/#{client_id}",
      method: :delete,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get M2M client
  """
  @spec get_client(String.t(), keyword) :: {:ok, any} | :error
  def get_client(client_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id],
      call: {Stytch.M2M, :get_client},
      url: "/v1/m2m/clients/#{client_id}",
      method: :get,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get access token
  """
  @spec get_token(String.t(), map, keyword) :: {:ok, any} | :error
  def get_token(project_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id, body: body],
      call: {Stytch.M2M, :get_token},
      url: "/v1/public/#{project_id}/oauth2/token",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Rotate secret
  """
  @spec rotate_secret(String.t(), keyword) :: {:ok, any} | :error
  def rotate_secret(client_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id],
      call: {Stytch.M2M, :rotate_secret},
      url: "/v1/m2m/clients/#{client_id}/secrets/rotate",
      method: :post,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Search M2M clients
  """
  @spec search_clients(map, keyword) :: {:ok, any} | :error
  def search_clients(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.M2M, :search_clients},
      url: "/v1/m2m/clients/search",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Start secret rotation
  """
  @spec start_secret_rotation(String.t(), keyword) :: {:ok, any} | :error
  def start_secret_rotation(client_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id],
      call: {Stytch.M2M, :start_secret_rotation},
      url: "/v1/m2m/clients/#{client_id}/secrets/rotate/start",
      method: :post,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Update M2M client
  """
  @spec update_client(String.t(), map, keyword) :: {:ok, any} | :error
  def update_client(client_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id, body: body],
      call: {Stytch.M2M, :update_client},
      url: "/v1/m2m/clients/#{client_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
