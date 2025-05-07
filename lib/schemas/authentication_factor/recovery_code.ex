defmodule Stytch.AuthenticationFactor.RecoveryCode do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.RecoveryCode
  """

  @type t :: %__MODULE__{totp_recovery_code_id: String.t()}

  defstruct [:totp_recovery_code_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [totp_recovery_code_id: {:string, :generic}]
  end
end
