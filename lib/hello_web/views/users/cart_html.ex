defmodule HelloWeb.CartHTML do
  use HelloWeb, :html

  embed_templates "../../templates/users/cart_html/*"

  def currency_to_str(%Decimal{} = val), do: "$#{Decimal.round(val, 2)}"
end
