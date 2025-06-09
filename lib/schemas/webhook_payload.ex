defmodule Stytch.WebhookPayload do
  @moduledoc """
  Provides struct and type for a WebhookPayload
  """

  @type t :: %__MODULE__{
          action: String.t(),
          event_id: String.t(),
          id: String.t(),
          member: Stytch.Member.t() | nil,
          object_type: String.t(),
          oidc_connection: Stytch.OIDC.Connection.t() | nil,
          organization: Stytch.Organization.t() | nil,
          project_id: String.t(),
          saml_connection: Stytch.SAML.Connection.t() | nil,
          scim_group: Stytch.WebhookPayloadScimGroup.t() | nil,
          source: String.t(),
          timestamp: DateTime.t()
        }

  defstruct [
    :action,
    :event_id,
    :id,
    :member,
    :object_type,
    :oidc_connection,
    :organization,
    :project_id,
    :saml_connection,
    :scim_group,
    :source,
    :timestamp
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action: {:enum, ["CREATE", "UPDATE", "DELETE"]},
      event_id: {:string, :generic},
      id: {:string, :generic},
      member: {Stytch.Member, :t},
      object_type: {:string, :generic},
      oidc_connection: {Stytch.OIDC.Connection, :t},
      organization: {Stytch.Organization, :t},
      project_id: {:string, :generic},
      saml_connection: {Stytch.SAML.Connection, :t},
      scim_group: {Stytch.WebhookPayloadScimGroup, :t},
      source: {:enum, ["DASHBOARD", "DIRECT", "SCIM"]},
      timestamp: {:string, :date_time}
    ]
  end
end
