defmodule Stytch.EmailImplicitRoleAssignment do
  @moduledoc """
  Provides struct and type for a EmailImplicitRoleAssignment
  """

  @type t :: %__MODULE__{domain: String.t() | nil, role: String.t() | nil}

  defstruct [:domain, :role]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [domain: {:string, :generic}, role: {:string, :generic}]
  end
end
