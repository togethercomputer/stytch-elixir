defmodule Stytch.RBAC.PolicyScope do
  @moduledoc """
  Provides struct and type for a RBAC.PolicyScope
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          description: String.t(),
          permissions: [Stytch.RBAC.PolicyScopePermission.t()],
          scope: String.t()
        }

  defstruct [:description, :permissions, :scope]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: {:string, :generic},
      permissions: [{Stytch.RBAC.PolicyScopePermission, :t}],
      scope: {:string, :generic}
    ]
  end
end
