defmodule Hello.Favorites.FavoriteItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "favorite_items" do
    belongs_to :user_favorites, Hello.Favorites.UserFavorites
    belongs_to :phone, Hello.Catalog.Smartphones.Smartphone

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(favorite_item, attrs) do
    favorite_item
    |> cast(attrs, [])
    |> validate_required([])
  end
end
