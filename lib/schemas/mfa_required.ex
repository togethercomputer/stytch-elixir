defmodule Stytch.MFARequired do
  @moduledoc """
  Provides struct and type for a MFARequired
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          member_options: Stytch.Member.Options.t() | nil,
          secondary_auth_initiated: String.t() | nil
        }

  defstruct [:member_options, :secondary_auth_initiated]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [member_options: {Stytch.Member.Options, :t}, secondary_auth_initiated: {:string, :generic}]
  end
end
