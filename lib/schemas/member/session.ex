defmodule Stytch.Member.Session do
  @moduledoc """
  Provides struct and type for a Member.Session
  """

  @type t :: %__MODULE__{
          authentication_factors: [Stytch.AuthenticationFactor.t()],
          custom_claims: map | nil,
          expires_at: DateTime.t(),
          last_accessed_at: DateTime.t(),
          member_id: String.t(),
          member_session_id: String.t(),
          organization_id: String.t(),
          roles: [String.t()],
          started_at: DateTime.t()
        }

  defstruct [
    :authentication_factors,
    :custom_claims,
    :expires_at,
    :last_accessed_at,
    :member_id,
    :member_session_id,
    :organization_id,
    :roles,
    :started_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      authentication_factors: [{Stytch.AuthenticationFactor, :t}],
      custom_claims: :map,
      expires_at: {:string, :date_time},
      last_accessed_at: {:string, :date_time},
      member_id: {:string, :generic},
      member_session_id: {:string, :generic},
      organization_id: {:string, :generic},
      roles: [string: :generic],
      started_at: {:string, :date_time}
    ]
  end
end
