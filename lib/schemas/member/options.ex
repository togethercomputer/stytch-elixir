defmodule Stytch.Member.Options do
  @moduledoc """
  Provides struct and type for a Member.Options
  """
  use Stytch.Schema

  @type t :: %__MODULE__{mfa_phone_number: String.t(), totp_registration_id: String.t()}

  defstruct [:mfa_phone_number, :totp_registration_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [mfa_phone_number: {:string, :generic}, totp_registration_id: {:string, :generic}]
  end
end
