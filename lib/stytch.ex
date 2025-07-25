defmodule Stytch do
  @moduledoc """
  API Client for the Stytch B2B SaaS platform

  Much of the code in this module is auto-generated from the OpenAPI specification found in
  `vendor/stytch-openapi.yaml`. This is an unofficial, hand-crafted specification for the API.
  """

  @doc """
  Decode a webhook payload from Stytch
  """
  @spec decode_webhook(map) :: Stytch.WebhookPayload.t()
  def decode_webhook(payload) do
    Stytch.Decoder.decode_direct(payload, {Stytch.WebhookPayload, :t})
  end

  @doc """
  Verify a signed JWT using a key set provided by Stytch

  Returns the payload of the signed JWT if successful, or an error if there is no matching key.
  It is the caller's responsibility to check the expiration time (`exp` in the payload).

  In order to use this function, you must first start `Stytch.JWKS` in your application
  supervision tree. This process automatically fetches and caches the JWKS (JSON Web Key Set)
  provided by Stytch. If you need support for multiple projects, you can start multiple instances
  of the `Stytch.JWKS` module with different names.

  ## Options

    * `name`: The name of the key set to use (defaults to `Stytch.JWKS`). This should match the
      name of the `Stytch.JWKS` process in your application supervision tree.

  """
  @spec verify_jwt(String.t()) :: {:ok, map} | {:error, Exception.t()}
  @spec verify_jwt(String.t(), keyword) :: {:ok, map} | {:error, Exception.t()}
  def verify_jwt(jwt, opts \\ []) do
    Stytch.JWKS.verify(jwt, opts)
  end

  @doc """
  Dangerously decode a signed JWT without verifying its signature

  Returns the payload of the signed JWT if successful, or an error if the JWT is malformed.
  This function should only be called on JWTs that are independently verified by the caller
  (such as those received directly from Stytch's API). User-provided JWTs could be changed in
  an unsigned way, and this function will not perform any verification.
  """
  @spec dangerously_decode_jwt(String.t()) :: {:ok, map} | {:error, Exception.t()}
  def dangerously_decode_jwt(jwt) do
    result =
      JOSE.JWS.peek_payload(jwt)
      |> JSON.decode!()

    {:ok, result}
  rescue
    e -> {:error, %RuntimeError{message: "Failed to decode JWT payload: #{inspect(e)}"}}
  end
end
