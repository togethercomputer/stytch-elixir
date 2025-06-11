defmodule Stytch.Schema do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      @derive Jason.Encoder
      @derive JSON.Encoder
    end
  end
end
