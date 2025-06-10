defmodule Stytch.X509Certificate do
  @moduledoc """
  Provides struct and type for a X509Certificate
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          certificate: String.t(),
          certificate_id: String.t(),
          created_at: DateTime.t() | nil,
          expires_at: DateTime.t() | nil,
          issuer: String.t(),
          updated_at: DateTime.t() | nil
        }

  defstruct [:certificate, :certificate_id, :created_at, :expires_at, :issuer, :updated_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      certificate: {:string, :generic},
      certificate_id: {:string, :generic},
      created_at: {:string, :date_time},
      expires_at: {:string, :date_time},
      issuer: {:string, :generic},
      updated_at: {:string, :date_time}
    ]
  end
end
