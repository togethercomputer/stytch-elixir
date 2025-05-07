defmodule Stytch.Decoder do
  @moduledoc false

  @spec decode_response(term, map, integer) :: term
  def decode_response(response, details, code) do
    case get_type(details.response, code) |> IO.inspect() do
      {:ok, response_type} ->
        do_decode(response, response_type)

      {:error, :not_found} ->
        response
    end
  end

  defp get_type(types, code) do
    if res = Enum.find(types, fn {c, _} -> c == code end) do
      {:ok, elem(res, 1)}
    else
      {:error, :not_found}
    end
  end

  defp do_decode(nil, _), do: nil
  defp do_decode("", :null), do: nil
  defp do_decode(value, {:string, :date}), do: Date.from_iso8601!(value)
  defp do_decode(value, {:string, :date_time}), do: DateTime.from_iso8601(value) |> elem(1)
  defp do_decode(value, {:string, :time}), do: Time.from_iso8601!(value)
  defp do_decode(value, {:union, types}), do: do_decode(value, choose_union(value, types))

  defp do_decode(value, [type]), do: Enum.map(value, &do_decode(&1, type))

  defp do_decode(%{} = value, {module, type}) do
    base = if function_exported?(module, :__struct__, 0), do: struct(module), else: %{}
    fields = module.__fields__(type)

    for {field_name, field_type} <- fields, reduce: base do
      decoded_value ->
        case Map.fetch(value, to_string(field_name)) do
          {:ok, field_value} ->
            decoded_field_value = do_decode(field_value, field_type)
            Map.put(decoded_value, field_name, decoded_field_value)

          :error ->
            decoded_value
        end
    end
  end

  defp do_decode(value, _type), do: value

  #
  # Union Type Handlers
  #

  @spec choose_union(term, term) :: term
  defp choose_union(nil, [_type, :null]), do: :null
  defp choose_union(nil, [:null, _type]), do: :null
  defp choose_union(_value, [type, :null]), do: type
  defp choose_union(_value, [:null, type]), do: type

  defp choose_union(_value, types) do
    raise "Decoder: Unable to decode union type #{inspect(types)}; not implemented"
  end
end
