defmodule HelloWeb.OrderController do
  use HelloWeb, :controller

  require Logger
  alias Hello.Orders

  def create(conn, _) do
    case Orders.complete_order(conn.assigns.cart) do
      {:ok, order} ->
        conn
        |> put_flash(:info, "Заказ успешно создан")
        |> redirect(to: ~p"/orders/#{order}")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "При обработке вашего заказа произошла ошибка")
        |> redirect(to: ~p"/cart")
    end
  end

  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(conn.assigns.current_user.user_uuid, id)
    render(conn, :show, order: order)
  end

  def index(conn, _) do
    orders = Orders.list_orders(conn.assigns.current_user.user_uuid)
    render(conn, :index, orders: orders)
  end

  def update(conn, %{"order_id" => order_id, "phone_id" => phone_id, "operation" => operation}) do
    order_id = String.to_integer(order_id)
    phone_id = String.to_integer(phone_id)
    operation = String.to_integer(operation)

    order = Orders.get_order!(conn.assigns.current_user.user_uuid, order_id)

    item =
      Enum.find(order.line_items, fn item ->
        item.phone_id == phone_id
      end)

    new_quantity = item.quantity + operation

    if new_quantity <= 0 do
      case Orders.delete_line_item(item) do
        {:ok, _cart} ->
          order = Orders.get_order!(conn.assigns.current_user.user_uuid, order_id)

          if length(order.line_items) < 1 do
            Orders.delete_order(order)

            conn
            |> put_flash(:error, "Нет товаров для заказа")
            |> redirect(to: ~p"/")
          end

          Orders.update_order(order, %{total_price: Orders.total_order_price(order)})
          redirect(conn, to: ~p"/orders/#{order_id}")

        {:error, _reason} ->
          conn
          |> put_flash(:error, "Произошла ошибка при удалении товара из корзины")
          |> redirect(to: ~p"/orders/#{order_id}")
      end
    else
      case Orders.update_line_item(item, %{quantity: new_quantity}) do
        {:ok, _cart} ->
          order = Orders.get_order!(conn.assigns.current_user.user_uuid, order_id)
          Orders.update_order(order, %{total_price: Orders.total_order_price(order)})
          redirect(conn, to: ~p"/orders/#{order_id}")

        {:error, _changeset} ->
          conn
          |> put_flash(:error, "Произошла ошибка при обновлении корзины.")
          |> redirect(to: ~p"/orders/#{order_id}")
      end
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Orders.get_order!(conn.assigns.current_user.user_uuid, id)

    case Orders.delete_order(order) do
      {:ok, _order} ->
        conn
        |> put_flash(:success, "Заказ успешно удален")
        |> redirect(to: ~p"/orders")

      {:error, _} ->
        conn
        |> put_flash(:error, "Произошла ошибка при удаление товара")
        |> redirect(to: ~p"/orders")
    end
  end
end
