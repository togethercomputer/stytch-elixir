defmodule Stytch.WebhookPayloadScimGroup do
  @moduledoc """
  Provides struct and type for a WebhookPayloadScimGroup
  """

  @type t :: %__MODULE__{
          connection_id: String.t() | nil,
          group_id: String.t() | nil,
          group_name: String.t() | nil,
          organization_id: String.t() | nil
        }

  defstruct [:connection_id, :group_id, :group_name, :organization_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connection_id: {:string, :generic},
      group_id: {:string, :generic},
      group_name: {:string, :generic},
      organization_id: {:string, :generic}
    ]
  end
end
