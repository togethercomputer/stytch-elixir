defmodule Stytch.ActiveSCIMConnection do
  @moduledoc """
  Provides struct and type for a ActiveSCIMConnection
  """

  @type t :: %__MODULE__{
          bearer_token_expires_at: DateTime.t() | nil,
          bearer_token_last_four: String.t(),
          connection_id: String.t(),
          display_name: String.t()
        }

  defstruct [:bearer_token_expires_at, :bearer_token_last_four, :connection_id, :display_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bearer_token_expires_at: {:string, :date_time},
      bearer_token_last_four: {:string, :generic},
      connection_id: {:string, :generic},
      display_name: {:string, :generic}
    ]
  end
end
