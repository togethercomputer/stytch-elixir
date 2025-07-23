defmodule Stytch.Membership do
  @moduledoc """
  Provides struct and type for a Membership
  """
  use Stytch.Schema

  @type t :: %__MODULE__{details: map | nil, member: Stytch.Member.t() | nil, type: String.t()}

  defstruct [:details, :member, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [details: :map, member: {Stytch.Member, :t}, type: {:string, :generic}]
  end
end
