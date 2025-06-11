defmodule Stytch.OAuthRegistration do
  @moduledoc """
  Provides struct and type for a OAuthRegistration
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          locale: String.t() | nil,
          member_oauth_registration_id: String.t(),
          profile_picture_url: String.t() | nil,
          provider_subject: String.t(),
          provider_type: String.t()
        }

  defstruct [
    :locale,
    :member_oauth_registration_id,
    :profile_picture_url,
    :provider_subject,
    :provider_type
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      locale: {:string, :generic},
      member_oauth_registration_id: {:string, :generic},
      profile_picture_url: {:string, :generic},
      provider_subject: {:string, :generic},
      provider_type: {:string, :generic}
    ]
  end
end
