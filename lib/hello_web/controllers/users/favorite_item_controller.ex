defmodule HelloWeb.FavoriteItemController do
  use HelloWeb, :controller

  alias Hello.Favorites

  def create(conn, %{"phone_id" => phone_id}) do
    case Favorites.add_or_delete_favorite_item(conn.assigns.current_user.user_uuid, phone_id) do
      {:ok, :add} ->
        conn
        |> put_flash(:info, "Товар добавлен в избранное")
        |> redirect(to: ~p"/#{phone_id}")

      {:ok, :delete} ->
        conn
        |> put_flash(:info, "Товар удален из избранного")
        |> redirect(to: ~p"/#{phone_id}")
    end
  end

  def delete(conn, %{"id" => phone_id}) do
    :ok = Favorites.remove_item_from_favorite(conn.assigns.current_user.user_uuid, phone_id)
    redirect(conn, to: ~p"/favorites")
  end
end
