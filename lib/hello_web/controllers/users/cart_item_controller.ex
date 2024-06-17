defmodule HelloWeb.CartItemController do
  use HelloWeb, :controller

  alias Hello.ShoppingCart

  def create(conn, %{"phone_id" => phone_id}) do
    case ShoppingCart.add_item_to_cart(conn.assigns.cart, phone_id) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item added to your cart")
        |> redirect(to: ~p"/#{phone_id}")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error adding the item to your cart")
        |> redirect(to: ~p"/#{phone_id}")
    end
  end

  def delete(conn, %{"id" => phone_id}) do
    {:ok, _cart} = ShoppingCart.remove_item_from_cart(conn.assigns.cart, phone_id)
    redirect(conn, to: ~p"/cart")
  end
end
