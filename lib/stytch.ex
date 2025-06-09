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
    Stytch.Decoder.decode_direct(payload, Stytch.WebhookPayload)
  end
end
