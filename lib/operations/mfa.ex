defmodule Stytch.MFA do
  @moduledoc """
  Provides API endpoints related to mfa
  """

  @default_client Stytch.Client

  @doc """
  Authenticate
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MFA, :authenticate},
      url: "/v1/b2b/totp/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Recover
  """
  @spec recover(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def recover(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MFA, :recover},
      url: "/v1/b2b/recovery_codes/rotate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  Rotate recovery codes
  """
  @spec rotate_recovery_codes(body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Stytch.Error.t()}
  def rotate_recovery_codes(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MFA, :rotate_recovery_codes},
      url: "/v1/b2b/otps/sms/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end

  @doc """
  OTP SMS Send
  """
  @spec sms_send(body :: map, opts :: keyword) :: {:ok, map} | {:error, Stytch.Error.t()}
  def sms_send(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.MFA, :sms_send},
      url: "/v1/b2b/otps/sms/send",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end
end
