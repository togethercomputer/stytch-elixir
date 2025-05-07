defmodule Stytch.RetiredEmail do
  @moduledoc """
  Provides struct and type for a RetiredEmail
  """

  @type t :: %__MODULE__{email_address: String.t(), email_id: String.t()}

  defstruct [:email_address, :email_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email_address: {:string, :generic}, email_id: {:string, :generic}]
  end
end
