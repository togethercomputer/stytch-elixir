defmodule Stytch.RBAC.PolicyResource do
  @moduledoc """
  Provides struct and type for a RBAC.PolicyResource
  """
  use Stytch.Schema

  @type t :: %__MODULE__{actions: [String.t()], description: String.t(), resource_id: String.t()}

  defstruct [:actions, :description, :resource_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: [string: :generic],
      description: {:string, :generic},
      resource_id: {:string, :generic}
    ]
  end
end
