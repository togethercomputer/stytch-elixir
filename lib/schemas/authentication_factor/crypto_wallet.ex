defmodule Stytch.AuthenticationFactor.CryptoWallet do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.CryptoWallet
  """

  @type t :: %__MODULE__{
          crypto_wallet_address: String.t(),
          crypto_wallet_id: String.t(),
          crypto_wallet_type: String.t()
        }

  defstruct [:crypto_wallet_address, :crypto_wallet_id, :crypto_wallet_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      crypto_wallet_address: {:string, :generic},
      crypto_wallet_id: {:string, :generic},
      crypto_wallet_type: {:string, :generic}
    ]
  end
end
