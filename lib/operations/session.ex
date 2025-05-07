defmodule Stytch.Session do
  @moduledoc """
  Provides API endpoints related to session
  """

  @default_client Stytch.Client

  @doc """
  Authenticate Session
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, any} | :error
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :authenticate},
      url: "/v1/b2b/sessions/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Exchange session
  """
  @spec exchange(body :: map, opts :: keyword) :: {:ok, any} | :error
  def exchange(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :exchange},
      url: "/v1/b2b/sessions/exchange",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get Session

  ## Options

    * `organization_id`
    * `member_id`

  """
  @spec get(opts :: keyword) :: {:ok, any} | :error
  def get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:member_id, :organization_id])

    client.request(%{
      args: [],
      call: {Stytch.Session, :get},
      url: "/v1/b2b/sessions",
      method: :get,
      query: query,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Get JWKs
  """
  @spec get_jwks(project_id :: String.t(), opts :: keyword) :: {:ok, any} | :error
  def get_jwks(project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id],
      call: {Stytch.Session, :get_jwks},
      url: "/v1/b2b/sessions/jwks/#{project_id}",
      method: :get,
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Revoke Session
  """
  @spec revoke(body :: map, opts :: keyword) :: {:ok, any} | :error
  def revoke(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Session, :revoke},
      url: "/v1/b2b/sessions/revoke",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
