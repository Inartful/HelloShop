defmodule Hello.Helper do
  def format_with_spaces(number) when is_integer(number) do
    number
    |> Integer.to_string()
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
