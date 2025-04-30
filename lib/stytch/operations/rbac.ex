defmodule Stytch.Rbac do
  @moduledoc """
  Provides API endpoint related to rbac
  """

  @default_client Stytch.Client

  @doc """
  Get RBAC Policy
  """
  @spec get_policy(keyword) :: {:ok, any} | :error
  def get_policy(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Stytch.Rbac, :get_policy},
      url: "/v1/b2b/rbac/policy",
      method: :get,
      response: [{200, :unknown}],
      opts: opts
    })
  end
end
