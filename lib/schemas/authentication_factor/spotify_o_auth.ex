defmodule Stytch.AuthenticationFactor.SpotifyOAuth do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.SpotifyOAuth
  """
  use Stytch.Schema

  @type t :: %__MODULE__{email_id: String.t() | nil, id: String.t(), provider_subject: String.t()}

  defstruct [:email_id, :id, :provider_subject]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      email_id: {:string, :generic},
      id: {:string, :generic},
      provider_subject: {:string, :generic}
    ]
  end
end
