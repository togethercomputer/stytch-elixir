defmodule Stytch.ActiveSSOConnection do
  @moduledoc """
  Provides struct and type for a ActiveSSOConnection
  """

  @type t :: %__MODULE__{connection_id: String.t() | nil, display_name: String.t() | nil}

  defstruct [:connection_id, :display_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [connection_id: {:string, :generic}, display_name: {:string, :generic}]
  end
end
