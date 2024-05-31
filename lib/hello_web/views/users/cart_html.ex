defmodule HelloWeb.CartHTML do
  use HelloWeb, :html

  alias Hello.ShoppingCart

  embed_templates "../../templates/users/cart_html/*"

  def currency_to_str(%Decimal{} = val), do: "$#{Decimal.round(val, 2)}"
end
