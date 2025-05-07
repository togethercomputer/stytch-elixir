defmodule Stytch.Member.Role do
  @moduledoc """
  Provides struct and type for a Member.Role
  """

  @type t :: %__MODULE__{role_id: String.t(), sources: [Stytch.Member.RoleSource.t()]}

  defstruct [:role_id, :sources]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [role_id: {:string, :generic}, sources: [{Stytch.Member.RoleSource, :t}]]
  end
end
