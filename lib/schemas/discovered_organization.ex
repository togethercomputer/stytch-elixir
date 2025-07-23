defmodule Stytch.DiscoveredOrganization do
  @moduledoc """
  Provides struct and type for a DiscoveredOrganization
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          member_authenticated: boolean,
          membership: Stytch.Membership.t() | nil,
          mfa_required: Stytch.MFARequired.t() | nil,
          organization: Stytch.Organization.t() | nil,
          primary_required: Stytch.PrimaryRequired.t() | nil
        }

  defstruct [:member_authenticated, :membership, :mfa_required, :organization, :primary_required]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      member_authenticated: :boolean,
      membership: {Stytch.Membership, :t},
      mfa_required: {Stytch.MFARequired, :t},
      organization: {Stytch.Organization, :t},
      primary_required: {Stytch.PrimaryRequired, :t}
    ]
  end
end
