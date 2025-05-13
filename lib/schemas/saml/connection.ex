defmodule Stytch.SAML.Connection do
  @moduledoc """
  Provides struct and type for a SAML.Connection
  """

  @type t :: %__MODULE__{
          acs_url: String.t(),
          alternative_acs_url: String.t(),
          alternative_audience_uri: String.t(),
          attribute_mapping: map | nil,
          audience_uri: String.t(),
          connection_id: String.t(),
          display_name: String.t(),
          identity_provider: String.t(),
          idp_entity_id: String.t(),
          idp_initiated_auth_disabled: boolean,
          idp_sso_url: String.t(),
          nameid_format: String.t(),
          organization_id: String.t(),
          saml_connection_implicit_role_assignments: [
            Stytch.SAML.ConnectionImplicitRoleAssignment.t()
          ],
          saml_group_implicit_role_assignments: [Stytch.SAML.GroupImplicitRoleAssignment.t()],
          signing_certificates: [Stytch.X509Certificate.t()],
          status: String.t(),
          verification_certificates: [Stytch.X509Certificate.t()]
        }

  defstruct [
    :acs_url,
    :alternative_acs_url,
    :alternative_audience_uri,
    :attribute_mapping,
    :audience_uri,
    :connection_id,
    :display_name,
    :identity_provider,
    :idp_entity_id,
    :idp_initiated_auth_disabled,
    :idp_sso_url,
    :nameid_format,
    :organization_id,
    :saml_connection_implicit_role_assignments,
    :saml_group_implicit_role_assignments,
    :signing_certificates,
    :status,
    :verification_certificates
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      acs_url: {:string, :generic},
      alternative_acs_url: {:string, :generic},
      alternative_audience_uri: {:string, :generic},
      attribute_mapping: :map,
      audience_uri: {:string, :generic},
      connection_id: {:string, :generic},
      display_name: {:string, :generic},
      identity_provider: {:string, :generic},
      idp_entity_id: {:string, :generic},
      idp_initiated_auth_disabled: :boolean,
      idp_sso_url: {:string, :generic},
      nameid_format: {:string, :generic},
      organization_id: {:string, :generic},
      saml_connection_implicit_role_assignments: [
        {Stytch.SAML.ConnectionImplicitRoleAssignment, :t}
      ],
      saml_group_implicit_role_assignments: [{Stytch.SAML.GroupImplicitRoleAssignment, :t}],
      signing_certificates: [{Stytch.X509Certificate, :t}],
      status: {:string, :generic},
      verification_certificates: [{Stytch.X509Certificate, :t}]
    ]
  end
end
