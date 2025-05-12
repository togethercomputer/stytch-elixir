defmodule Stytch.OIDCProviderInfo do
  @moduledoc """
  Provides struct and type for a OIDCProviderInfo
  """

  @type t :: %__MODULE__{
          access_token: String.t(),
          access_token_expires_at: DateTime.t(),
          connection_id: String.t(),
          id_token: String.t(),
          provider_subject: String.t(),
          refresh_token: String.t() | nil,
          scopes: [String.t()]
        }

  defstruct [
    :access_token,
    :access_token_expires_at,
    :connection_id,
    :id_token,
    :provider_subject,
    :refresh_token,
    :scopes
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      access_token: {:string, :generic},
      access_token_expires_at: {:string, :date_time},
      connection_id: {:string, :generic},
      id_token: {:string, :generic},
      provider_subject: {:string, :generic},
      refresh_token: {:string, :generic},
      scopes: [string: :generic]
    ]
  end
end
