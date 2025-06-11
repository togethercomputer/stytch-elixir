defmodule Stytch.EmailImplicitRoleAssignment do
  @moduledoc """
  Provides struct and type for a EmailImplicitRoleAssignment
  """
  use Stytch.Schema

  @type t :: %__MODULE__{domain: String.t(), role_id: String.t()}

  defstruct [:domain, :role_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [domain: {:string, :generic}, role_id: {:string, :generic}]
  end
end
