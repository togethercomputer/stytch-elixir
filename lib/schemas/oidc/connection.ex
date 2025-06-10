defmodule Stytch.OIDC.Connection do
  @moduledoc """
  Provides struct and type for a OIDC.Connection
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          attribute_mapping: map | nil,
          authorization_url: String.t(),
          client_id: String.t(),
          client_secret: String.t(),
          connection_id: String.t(),
          custom_scopes: String.t(),
          display_name: String.t(),
          identity_provider: String.t(),
          issuer: String.t(),
          jwks_url: String.t(),
          organization_id: String.t(),
          redirect_url: String.t(),
          status: String.t(),
          token_url: String.t(),
          userinfo_url: String.t()
        }

  defstruct [
    :attribute_mapping,
    :authorization_url,
    :client_id,
    :client_secret,
    :connection_id,
    :custom_scopes,
    :display_name,
    :identity_provider,
    :issuer,
    :jwks_url,
    :organization_id,
    :redirect_url,
    :status,
    :token_url,
    :userinfo_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      attribute_mapping: :map,
      authorization_url: {:string, :generic},
      client_id: {:string, :generic},
      client_secret: {:string, :generic},
      connection_id: {:string, :generic},
      custom_scopes: {:string, :generic},
      display_name: {:string, :generic},
      identity_provider: {:string, :generic},
      issuer: {:string, :generic},
      jwks_url: {:string, :generic},
      organization_id: {:string, :generic},
      redirect_url: {:string, :generic},
      status: {:string, :generic},
      token_url: {:string, :generic},
      userinfo_url: {:string, :generic}
    ]
  end
end
