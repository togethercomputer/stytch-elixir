defmodule Stytch.AuthenticationFactor.AuthenticatorApp do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.AuthenticatorApp
  """
  use Stytch.Schema

  @type t :: %__MODULE__{totp_id: String.t()}

  defstruct [:totp_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [totp_id: {:string, :generic}]
  end
end
