defmodule Stytch.Impersonation do
  @moduledoc """
  Provides API endpoint related to impersonation
  """

  @default_client Stytch.Client

  @doc """
  Authenticate Impersonation Token
  """
  @spec authenticate(body :: map, opts :: keyword) :: {:ok, map} | :error
  def authenticate(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Stytch.Impersonation, :authenticate},
      url: "/v1/b2b/impersonation/authenticate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end
end
