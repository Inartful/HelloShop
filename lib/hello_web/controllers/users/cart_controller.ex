defmodule HelloWeb.CartController do
  use HelloWeb, :controller
  alias Hello.ShoppingCart

  def show(conn, _params) do
    render(conn, :show, cart: conn.assigns.cart)
  end

  def update(conn, %{"phone_id" => phone_id, "operation" => operation}) do
    item =
      Enum.find(conn.assigns.cart.items, fn item ->
        item.phone_id == String.to_integer(phone_id)
      end)

    new_quantity = item.quantity + String.to_integer(operation)

    if new_quantity == 0 do
      case ShoppingCart.delete_cart_item(item) do
        {:ok, _cart} ->
          redirect(conn, to: ~p"/cart")

        {:error, _reason} ->
          conn
          |> put_flash(:error, "There was an error removing the item from your cart")
          |> redirect(to: ~p"/cart")
      end
    else
      case ShoppingCart.update_cart_item(item, %{quantity: new_quantity}) do
        {:ok, _cart} ->
          redirect(conn, to: ~p"/cart")

        {:error, _changeset} ->
          conn
          |> put_flash(:error, "There was an error updating your cart")
          |> redirect(to: ~p"/cart")
      end
    end
  end
end
