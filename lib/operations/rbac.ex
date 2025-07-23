defmodule Stytch.RBAC do
  @moduledoc """
  Provides API endpoint related to rbac
  """

  @default_client Stytch.Client

  @type get_policy_200_json_resp :: %{
          policy: Stytch.RBAC.Policy.t() | nil,
          request_id: String.t(),
          status_code: integer
        }

  @doc """
  Get RBAC Policy
  """
  @spec get_policy(opts :: keyword) ::
          {:ok, Stytch.RBAC.get_policy_200_json_resp()} | {:error, Stytch.Error.t()}
  def get_policy(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {Stytch.RBAC, :get_policy},
      url: "/v1/b2b/rbac/policy",
      method: :get,
      response: [
        {200, {Stytch.RBAC, :get_policy_200_json_resp}},
        default: {Stytch.ErrorResponse, :t}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:get_policy_200_json_resp) do
    [policy: {Stytch.RBAC.Policy, :t}, request_id: {:string, :generic}, status_code: :integer]
  end
end
