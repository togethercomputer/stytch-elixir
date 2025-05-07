defmodule Stytch.Mfa do
  @moduledoc """
  Provides API endpoints related to mfa
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
      call: {Stytch.Mfa, :authenticate},
      url: "/v1/b2b/totp/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Recover
  """
  @spec recover(body :: map, opts :: keyword) :: {:ok, any} | :error
  def recover(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Mfa, :recover},
      url: "/v1/b2b/recovery_codes/rotate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  Rotate recovery codes
  """
  @spec rotate_recovery_codes(body :: map, opts :: keyword) :: {:ok, any} | :error
  def rotate_recovery_codes(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Mfa, :rotate_recovery_codes},
      url: "/v1/b2b/otps/sms/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end

  @doc """
  OTP SMS Send
  """
  @spec sms_send(body :: map, opts :: keyword) :: {:ok, any} | :error
  def sms_send(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Mfa, :sms_send},
      url: "/v1/b2b/otps/sms/send",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
