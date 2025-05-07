defmodule Stytch.SSORegistration do
  @moduledoc """
  Provides struct and type for a SSORegistration
  """

  @type t :: %__MODULE__{
          connection_id: String.t(),
          external_id: String.t(),
          registration_id: String.t(),
          sso_attributes: map | nil
        }

  defstruct [:connection_id, :external_id, :registration_id, :sso_attributes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connection_id: {:string, :generic},
      external_id: {:string, :generic},
      registration_id: {:string, :generic},
      sso_attributes: :map
    ]
  end
end
