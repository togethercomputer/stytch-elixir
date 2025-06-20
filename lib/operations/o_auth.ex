defmodule Stytch.OAuth do
  @moduledoc """
  Provides API endpoints related to o auth
  """

  @default_client Stytch.Client

  @doc """
  Authenticate OAuth
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.OAuth, :authenticate},
      url: "/v1/b2b/oauth/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Authenticate discovery OAuth
  """
  @spec authenticate_discovery(body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.OAuth, :authenticate_discovery},
      url: "/v1/b2b/oauth/discovery/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Use Google for discovery

  ## Options

    * `public_token`

  """
  @spec discovery_google(opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def discovery_google(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :discovery_google},
      url: "/v1/b2b/public/oauth/google/discovery/start",
      method: :get,
      query: query,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Use Microsoft for discovery

  ## Options

    * `public_token`

  """
  @spec discovery_microsoft(opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def discovery_microsoft(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :discovery_microsoft},
      url: "/v1/b2b/public/oauth/microsoft/discovery/start",
      method: :get,
      query: query,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Login with Google

  ## Options

    * `public_token`

  """
  @spec login_google(opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def login_google(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_google},
      url: "/v1/b2b/public/oauth/google/start",
      method: :get,
      query: query,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Login with Microsoft

  ## Options

    * `public_token`

  """
  @spec login_microsoft(opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def login_microsoft(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:public_token])

    client.request(%{
      args: [],
      call: {Stytch.OAuth, :login_microsoft},
      url: "/v1/b2b/public/oauth/microsoft/start",
      method: :get,
      query: query,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end
end
