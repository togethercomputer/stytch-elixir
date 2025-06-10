defmodule Stytch.SAML.GroupImplicitRoleAssignment do
  @moduledoc """
  Provides struct and type for a SAML.GroupImplicitRoleAssignment
  """
  use Stytch.Schema

  @type t :: %__MODULE__{group: String.t(), role_id: String.t()}

  defstruct [:group, :role_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [group: {:string, :generic}, role_id: {:string, :generic}]
  end
end
