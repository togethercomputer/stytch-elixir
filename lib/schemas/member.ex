defmodule Stytch.Member do
  @moduledoc """
  Provides struct and type for a Member
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          created_at: DateTime.t() | nil,
          default_mfa_method: String.t(),
          email_address: String.t(),
          email_address_verified: boolean,
          external_id: String.t() | nil,
          is_admin: boolean,
          is_breakglass: boolean,
          member_id: String.t(),
          member_password_id: String.t(),
          mfa_enrolled: boolean,
          mfa_phone_number: String.t(),
          mfa_phone_number_verified: boolean,
          name: String.t(),
          oauth_registrations: [Stytch.OAuthRegistration.t()],
          organization_id: String.t(),
          retired_email_addresses: [Stytch.RetiredEmail.t()],
          roles: [Stytch.Member.Role.t()],
          scim_registration: Stytch.SCIMRegistration.t() | nil,
          sso_registrations: [Stytch.SSORegistration.t()],
          status: String.t(),
          totp_registration_id: String.t(),
          trusted_metadata: map | nil,
          untrusted_metadata: map | nil,
          updated_at: DateTime.t() | nil
        }

  defstruct [
    :created_at,
    :default_mfa_method,
    :email_address,
    :email_address_verified,
    :external_id,
    :is_admin,
    :is_breakglass,
    :member_id,
    :member_password_id,
    :mfa_enrolled,
    :mfa_phone_number,
    :mfa_phone_number_verified,
    :name,
    :oauth_registrations,
    :organization_id,
    :retired_email_addresses,
    :roles,
    :scim_registration,
    :sso_registrations,
    :status,
    :totp_registration_id,
    :trusted_metadata,
    :untrusted_metadata,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:string, :date_time},
      default_mfa_method: {:string, :generic},
      email_address: {:string, :generic},
      email_address_verified: :boolean,
      external_id: {:string, :generic},
      is_admin: :boolean,
      is_breakglass: :boolean,
      member_id: {:string, :generic},
      member_password_id: {:string, :generic},
      mfa_enrolled: :boolean,
      mfa_phone_number: {:string, :generic},
      mfa_phone_number_verified: :boolean,
      name: {:string, :generic},
      oauth_registrations: [{Stytch.OAuthRegistration, :t}],
      organization_id: {:string, :generic},
      retired_email_addresses: [{Stytch.RetiredEmail, :t}],
      roles: [{Stytch.Member.Role, :t}],
      scim_registration: {Stytch.SCIMRegistration, :t},
      sso_registrations: [{Stytch.SSORegistration, :t}],
      status: {:string, :generic},
      totp_registration_id: {:string, :generic},
      trusted_metadata: :map,
      untrusted_metadata: :map,
      updated_at: {:string, :date_time}
    ]
  end
end
