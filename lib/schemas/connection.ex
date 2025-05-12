defmodule Stytch.Connection do
  @moduledoc """
  Provides struct and type for a Connection
  """

  @type t :: %__MODULE__{
          connection_id: String.t(),
          display_name: String.t(),
          external_connection_id: String.t(),
          external_connection_implicit_role_assignments: [
            Stytch.ConnectionImplicitRoleAssignment.t()
          ],
          external_group_implicit_role_assignments: [Stytch.GroupImplicitRoleAssignment.t()],
          external_organization_id: String.t(),
          organization_id: String.t(),
          status: String.t()
        }

  defstruct [
    :connection_id,
    :display_name,
    :external_connection_id,
    :external_connection_implicit_role_assignments,
    :external_group_implicit_role_assignments,
    :external_organization_id,
    :organization_id,
    :status
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connection_id: {:string, :generic},
      display_name: {:string, :generic},
      external_connection_id: {:string, :generic},
      external_connection_implicit_role_assignments: [
        {Stytch.ConnectionImplicitRoleAssignment, :t}
      ],
      external_group_implicit_role_assignments: [{Stytch.GroupImplicitRoleAssignment, :t}],
      external_organization_id: {:string, :generic},
      organization_id: {:string, :generic},
      status: {:string, :generic}
    ]
  end
end
