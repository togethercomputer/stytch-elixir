defmodule Stytch.SCIMRegistration do
  @moduledoc """
  Provides struct and type for a SCIMRegistration
  """

  @type t :: %__MODULE__{
          connection_id: String.t(),
          external_id: String.t() | nil,
          registration_id: String.t(),
          scim_attributes: map | nil
        }

  defstruct [:connection_id, :external_id, :registration_id, :scim_attributes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connection_id: {:string, :generic},
      external_id: {:string, :generic},
      registration_id: {:string, :generic},
      scim_attributes: :map
    ]
  end
end
