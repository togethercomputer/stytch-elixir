defmodule Stytch.AuthenticationFactor.Impersonated do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.Impersonated
  """
  use Stytch.Schema

  @type t :: %__MODULE__{impersonator_email_address: String.t(), impersonator_id: String.t()}

  defstruct [:impersonator_email_address, :impersonator_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [impersonator_email_address: {:string, :generic}, impersonator_id: {:string, :generic}]
  end
end
