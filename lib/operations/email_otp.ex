defmodule Stytch.EmailOTP do
  @moduledoc """
  Provides API endpoints related to email otp
  """

  @default_client Stytch.Client

  @doc """
  Authenticate One-time Passcode (OTP)
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.EmailOTP, :authenticate},
      url: "/v1/b2b/otps/email/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Authenticate Discovery One-Time Passcode (OTP)
  """
  @spec authenticate_discovery(body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.EmailOTP, :authenticate_discovery},
      url: "/v1/b2b/otps/email/discovery/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Send login or signup email
  """
  @spec login_or_signup(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def login_or_signup(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.EmailOTP, :login_or_signup},
      url: "/v1/b2b/otps/email/login_or_signup",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Send Discovery Email OTP
  """
  @spec send_discovery(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def send_discovery(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.EmailOTP, :send_discovery},
      url: "/v1/b2b/otps/email/discovery/send",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end
end
