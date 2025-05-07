defmodule Stytch.Passwords do
  @moduledoc """
  Provides API endpoints related to passwords
  """

  @default_client Stytch.Client

  @doc """
  Authenticate
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, any} | :error
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :authenticate},
      url: "/v1/b2b/passwords/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Password reset by email
  """
  @spec email_reset(body :: map, opts :: keyword) :: {:ok, any} | :error
  def email_reset(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :email_reset},
      url: "/v1/b2b/passwords/email/reset",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Password reset by email start
  """
  @spec email_reset_start(body :: map, opts :: keyword) :: {:ok, any} | :error
  def email_reset_start(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :email_reset_start},
      url: "/v1/b2b/passwords/email/reset/start",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Password reset by existing password
  """
  @spec existing_reset(body :: map, opts :: keyword) :: {:ok, any} | :error
  def existing_reset(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :existing_reset},
      url: "/v1/b2b/passwords/existing_password/reset",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Migrate
  """
  @spec migrate(body :: map, opts :: keyword) :: {:ok, any} | :error
  def migrate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :migrate},
      url: "/v1/b2b/passwords/migrate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Password reset by session
  """
  @spec session_reset(body :: map, opts :: keyword) :: {:ok, any} | :error
  def session_reset(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :session_reset},
      url: "/v1/b2b/passwords/session/reset",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Strength check
  """
  @spec strength_check(body :: map, opts :: keyword) :: {:ok, any} | :error
  def strength_check(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Passwords, :strength_check},
      url: "/v1/b2b/passwords/strength_check",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
