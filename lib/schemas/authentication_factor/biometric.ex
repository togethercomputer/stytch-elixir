defmodule Stytch.AuthenticationFactor.Biometric do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.Biometric
  """
  use Stytch.Schema

  @type t :: %__MODULE__{biometric_registration_id: String.t()}

  defstruct [:biometric_registration_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [biometric_registration_id: {:string, :generic}]
  end
end
