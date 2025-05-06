defmodule Stytch.Organization do
  @moduledoc """
  Provides struct and type for a Organization
  """

  @type t :: %__MODULE__{
          allowed_auth_methods: [String.t()] | nil,
          allowed_mfa_methods: [String.t()] | nil,
          allowed_oauth_tenants: map | nil,
          auth_methods: String.t() | nil,
          claimed_email_domains: [String.t()] | nil,
          created_at: DateTime.t() | nil,
          email_allowed_domains: [String.t()] | nil,
          email_invites: String.t() | nil,
          email_jit_provisioning: String.t() | nil,
          mfa_methods: String.t() | nil,
          mfa_policy: String.t() | nil,
          oauth_tenant_jit_provisioning: String.t() | nil,
          organization_id: String.t() | nil,
          organization_logo_url: String.t() | nil,
          organization_name: String.t() | nil,
          organization_slug: String.t() | nil,
          rbac_email_implicit_role_assignments: [Stytch.EmailImplicitRoleAssignment.t()] | nil,
          scim_active_connection: Stytch.ActiveSCIMConnection.t() | nil,
          sso_active_connections: [Stytch.ActiveSSOConnection.t()] | nil,
          sso_default_connection_id: String.t() | nil,
          sso_jit_provisioning: String.t() | nil,
          sso_jit_provisioning_allowed_connections: [String.t()] | nil,
          trusted_metadata: map | nil,
          updated_at: DateTime.t() | nil
        }

  defstruct [
    :allowed_auth_methods,
    :allowed_mfa_methods,
    :allowed_oauth_tenants,
    :auth_methods,
    :claimed_email_domains,
    :created_at,
    :email_allowed_domains,
    :email_invites,
    :email_jit_provisioning,
    :mfa_methods,
    :mfa_policy,
    :oauth_tenant_jit_provisioning,
    :organization_id,
    :organization_logo_url,
    :organization_name,
    :organization_slug,
    :rbac_email_implicit_role_assignments,
    :scim_active_connection,
    :sso_active_connections,
    :sso_default_connection_id,
    :sso_jit_provisioning,
    :sso_jit_provisioning_allowed_connections,
    :trusted_metadata,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowed_auth_methods: [
        enum: [
          "sso",
          "magic_link",
          "email_otp",
          "password",
          "google_oauth",
          "microsoft_oauth",
          "slack_oauth",
          "github_oauth",
          "hubspot_oauth"
        ]
      ],
      allowed_mfa_methods: [enum: ["sms_otp", "totp"]],
      allowed_oauth_tenants: :map,
      auth_methods: {:enum, ["ALL_ALLOWED", "RESTRICTED"]},
      claimed_email_domains: [string: :generic],
      created_at: {:string, :date_time},
      email_allowed_domains: [string: :generic],
      email_invites: {:enum, ["ALL_ALLOWED", "RESTRICTED", "NOT_ALLOWED"]},
      email_jit_provisioning: {:enum, ["RESTRICTED", "NOT_ALLOWED"]},
      mfa_methods: {:enum, ["ALL_ALLOWED", "RESTRICTED"]},
      mfa_policy: {:enum, ["REQUIRED_FOR_ALL", "OPTIONAL"]},
      oauth_tenant_jit_provisioning: {:enum, ["RESTRICTED", "NOT_ALLOWED"]},
      organization_id: {:string, :generic},
      organization_logo_url: {:string, :generic},
      organization_name: {:string, :generic},
      organization_slug: {:string, :generic},
      rbac_email_implicit_role_assignments: [{Stytch.EmailImplicitRoleAssignment, :t}],
      scim_active_connection: {Stytch.ActiveSCIMConnection, :t},
      sso_active_connections: [{Stytch.ActiveSSOConnection, :t}],
      sso_default_connection_id: {:string, :generic},
      sso_jit_provisioning: {:enum, ["ALL_ALLOWED", "RESTRICTED", "NOT_ALLOWED"]},
      sso_jit_provisioning_allowed_connections: [string: :generic],
      trusted_metadata: :map,
      updated_at: {:string, :date_time}
    ]
  end
end
