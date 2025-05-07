defmodule Stytch.AuthenticationFactor.WebAuthn do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.WebAuthn
  """

  @type t :: %__MODULE__{
          domain: String.t(),
          user_agent: String.t() | nil,
          webauthn_registration_id: String.t()
        }

  defstruct [:domain, :user_agent, :webauthn_registration_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      domain: {:string, :generic},
      user_agent: {:string, :generic},
      webauthn_registration_id: {:string, :generic}
    ]
  end
end
