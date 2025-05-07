defmodule Stytch.AuthenticationFactor.OAuthAccessTokenExchange do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.OAuthAccessTokenExchange
  """

  @type t :: %__MODULE__{client_id: String.t()}

  defstruct [:client_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [client_id: {:string, :generic}]
  end
end
