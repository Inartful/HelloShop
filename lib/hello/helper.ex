defmodule Hello.Helper do
  alias Decimal, as: D

  def format_with_spaces(number) when is_float(number) do
    [int_part, frac_parts] = Float.to_string(number) |> String.split(".")
    formatted_int_part = format_integer_with_spaces(int_part)
    formatted_frac_part = Enum.join(frac_parts, ".")

    if formatted_frac_part != nil do
      formatted_int_part <> "." <> formatted_frac_part
    else
      formatted_int_part
    end
  end

  def format_with_spaces(number) when is_integer(number) do
    number
    |> Integer.to_string()
    |> String.reverse()
    |> split_every_three()
    |> Enum.join(" ")
    |> String.reverse()
  end

  def format_with_spaces(%D{} = number) do
    [int_part | frac_parts] = D.to_string(number) |> String.split(".")
    formatted_int_part = format_integer_with_spaces(int_part)
    formatted_frac_part = Enum.join(frac_parts, ".")

    if formatted_frac_part != "" do
      formatted_int_part <> "." <> formatted_frac_part
    else
      formatted_int_part
    end
  end

  defp format_integer_with_spaces(number_str) do
    number_str
    |> String.reverse()
    |> split_every_three()
    |> Enum.join(" ")
    |> String.reverse()
  end

  defp split_every_three(<<a, b, c>> <> rest) do
    [<<a, b, c>> | split_every_three(rest)]
  end

  defp split_every_three(<<a, b>> <> rest) do
    [<<a, b>> | split_every_three(rest)]
  end

  defp split_every_three(<<a>>) do
    [<<a>>]
  end

  defp split_every_three("") do
    []
  end
end
