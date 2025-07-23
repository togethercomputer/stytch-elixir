defmodule Stytch.RBAC.Policy do
  @moduledoc """
  Provides struct and type for a RBAC.Policy
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          resources: [Stytch.RBAC.PolicyResource.t()],
          roles: [Stytch.RBAC.PolicyRole.t()],
          scopes: [Stytch.RBAC.PolicyScope.t()]
        }

  defstruct [:resources, :roles, :scopes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      resources: [{Stytch.RBAC.PolicyResource, :t}],
      roles: [{Stytch.RBAC.PolicyRole, :t}],
      scopes: [{Stytch.RBAC.PolicyScope, :t}]
    ]
  end
end
