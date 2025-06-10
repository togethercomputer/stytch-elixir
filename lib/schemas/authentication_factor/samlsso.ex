defmodule Stytch.AuthenticationFactor.SAMLSSO do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.SAMLSSO
  """
  use Stytch.Schema

  @type t :: %__MODULE__{external_id: String.t(), id: String.t(), provider_id: String.t()}

  defstruct [:external_id, :id, :provider_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [external_id: {:string, :generic}, id: {:string, :generic}, provider_id: {:string, :generic}]
  end
end
