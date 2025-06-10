defmodule Stytch.AuthenticationFactor.EmbeddableMagicLink do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.EmbeddableMagicLink
  """
  use Stytch.Schema

  @type t :: %__MODULE__{embedded_id: String.t()}

  defstruct [:embedded_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [embedded_id: {:string, :generic}]
  end
end
