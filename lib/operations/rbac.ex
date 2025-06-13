defmodule Stytch.RBAC do
  @moduledoc """
  Provides API endpoint related to rbac
  """

  @default_client Stytch.Client

  @doc """
  Get RBAC Policy
  """
  @spec get_policy(opts :: keyword) :: {:ok, map} | {:error, Stytch.ErrorResponse.t()}
  def get_policy(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Stytch.RBAC, :get_policy},
      url: "/v1/b2b/rbac/policy",
      method: :get,
      response: [{200, :map}, default: {Stytch.ErrorResponse, :t}],
      opts: opts
    })
  end
end
