defmodule Hello.Favorites.UserFavorites do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_favorites" do
    field :user_uuid, Ecto.UUID

    has_many :items, Hello.Favorites.FavoriteItem

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(users_favorites, attrs) do
    users_favorites
    |> cast(attrs, [:user_uuid])
    |> validate_required([:user_uuid])
    |> unique_constraint(:user_uuid)
  end
end
