defmodule Stytch.PrimaryRequired do
  @moduledoc """
  Provides struct and type for a PrimaryRequired
  """
  use Stytch.Schema

  @type t :: %__MODULE__{allowed_auth_methods: [String.t()]}

  defstruct [:allowed_auth_methods]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [allowed_auth_methods: [string: :generic]]
  end
end
