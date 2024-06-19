defmodule HelloWeb.FavoriteController do
  use HelloWeb, :controller

  alias Hello.Favorites

  def show(conn, _) do
    favorites = Favorites.get_favorites_by_user_uuid(conn.assigns.current_user.user_uuid)
    render(conn, :show, favorite_items: favorites.items)
  end
end
