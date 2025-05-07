defmodule Stytch.AuthenticationFactor.PhoneNumber do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.PhoneNumber
  """

  @type t :: %__MODULE__{phone_id: String.t(), phone_number: String.t()}

  defstruct [:phone_id, :phone_number]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [phone_id: {:string, :generic}, phone_number: {:string, :generic}]
  end
end
