defmodule Stytch.ActiveSSOConnection do
  @moduledoc """
  Provides struct and type for a ActiveSSOConnection
  """

  @type t :: %__MODULE__{
          connection_id: String.t(),
          display_name: String.t(),
          identity_provider: String.t()
        }

  defstruct [:connection_id, :display_name, :identity_provider]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      connection_id: {:string, :generic},
      display_name: {:string, :generic},
      identity_provider: {:string, :generic}
    ]
  end
end
