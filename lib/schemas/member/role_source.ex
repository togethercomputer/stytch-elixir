defmodule Stytch.Member.RoleSource do
  @moduledoc """
  Provides struct and type for a Member.RoleSource
  """
  use Stytch.Schema

  @type t :: %__MODULE__{details: map | nil, type: String.t()}

  defstruct [:details, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [details: :map, type: {:string, :generic}]
  end
end
