defmodule Stytch.ConnectionImplicitRoleAssignment do
  @moduledoc """
  Provides struct and type for a ConnectionImplicitRoleAssignment
  """
  use Stytch.Schema

  @type t :: %__MODULE__{role_id: String.t()}

  defstruct [:role_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [role_id: {:string, :generic}]
  end
end
