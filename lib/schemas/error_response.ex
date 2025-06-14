defmodule Stytch.ErrorResponse do
  @moduledoc """
  Provides struct and type for a ErrorResponse
  """
  use Stytch.Schema

  @type t :: %__MODULE__{
          error_message: String.t() | nil,
          error_type: String.t() | nil,
          error_url: String.t() | nil,
          request_id: String.t() | nil,
          status_code: integer | nil
        }

  defstruct [:error_message, :error_type, :error_url, :request_id, :status_code]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      error_message: {:string, :generic},
      error_type: {:string, :generic},
      error_url: {:string, :generic},
      request_id: {:string, :generic},
      status_code: :integer
    ]
  end
end
