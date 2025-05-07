defmodule Stytch.MagicLinks do
  @moduledoc """
  Provides API endpoints related to magic links
  """

  @default_client Stytch.Client

  @doc """
  Authenticate Magic Link
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, map} | :error
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :authenticate},
      url: "/v1/b2b/magic_links/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Authenticate discovery Magic Link
  """
  @spec authenticate_discovery(body :: map, opts :: keyword) :: {:ok, map} | :error
  def authenticate_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :authenticate_discovery},
      url: "/v1/b2b/magic_links/discovery/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Send invite email
  """
  @spec invite(body :: map, opts :: keyword) :: {:ok, map} | :error
  def invite(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :invite},
      url: "/v1/b2b/magic_links/email/invite",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Send login or signup email
  """
  @spec login_or_signup(body :: map, opts :: keyword) :: {:ok, map} | :error
  def login_or_signup(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :login_or_signup},
      url: "/v1/b2b/magic_links/email/login_or_signup",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Send discovery email
  """
  @spec send_discovery(body :: map, opts :: keyword) :: {:ok, map} | :error
  def send_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MagicLinks, :send_discovery},
      url: "/v1/b2b/magic_links/email/discovery/send",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end
end
