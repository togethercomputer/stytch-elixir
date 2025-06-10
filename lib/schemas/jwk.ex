defmodule Stytch.JWK do
  @moduledoc """
  Provides struct and type for a JWK
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          alg: String.t() | nil,
          e: String.t() | nil,
          key_ops: [String.t()] | nil,
          kid: String.t(),
          kty: String.t(),
          n: String.t() | nil,
          use: String.t() | nil,
          x5c: [String.t()] | nil
        }

  defstruct [:alg, :e, :key_ops, :kid, :kty, :n, :use, :x5c]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      alg: {:string, :generic},
      e: {:string, :generic},
      key_ops: [string: :generic],
      kid: {:string, :generic},
      kty: {:string, :generic},
      n: {:string, :generic},
      use: {:string, :generic},
      x5c: [string: :generic]
    ]
  end
end
