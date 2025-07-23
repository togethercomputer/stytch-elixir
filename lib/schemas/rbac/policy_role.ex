defmodule Stytch.RBAC.PolicyRole do
  @moduledoc """
  Provides struct and type for a RBAC.PolicyRole
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          description: String.t(),
          permissions: [Stytch.RBAC.PolicyRolePermission.t()],
          role_id: String.t()
        }

  defstruct [:description, :permissions, :role_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      permissions: [{Stytch.RBAC.PolicyRolePermission, :t}],
      role_id: {:string, :generic}
    ]
  end
end
