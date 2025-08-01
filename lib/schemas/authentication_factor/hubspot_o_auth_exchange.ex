defmodule Stytch.AuthenticationFactor.HubspotOAuthExchange do
  @moduledoc """
  Provides struct and type for a AuthenticationFactor.HubspotOAuthExchange
  """
  use Stytch.Schema

  @type t :: %__MODULE__{email_id: String.t()}

  defstruct [:email_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email_id: {:string, :generic}]
  end
end
