defmodule Hello.Favorites do
  @moduledoc """
  The Favorites context.
  """

  import Ecto.Query, warn: false
  alias Hello.Repo

  alias Hello.Favorites.UserFavorites
  alias Hello.Catalog

  def get_favorites_by_user_uuid(user_uuid) do
    favorites =
      Repo.one(
        from(u in UserFavorites,
          where: u.user_uuid == ^user_uuid
          # left_join: i in assoc(u, :items),
          # left_join: p in assoc(i, :smartphones),
          # order_by: [asc: i.inserted_at],
          # preload: [items: {i, phone: p}]
        )
      )

    favorites =
      favorites
      |> Repo.preload(
        items: [
          phone: [
            spec: [
              :processor,
              :gpu,
              :screen,
              :main_camera,
              :front_camera,
              :operation_system,
              :dimensions
            ],
            colors: [],
            materials: [],
            photos: []
          ]
        ]
      )

    case favorites do
      nil ->
        create_user_favorites(%{user_uuid: user_uuid})
        get_favorites_by_user_uuid(user_uuid)

      favorites ->
        favorites
    end
  end

  @doc """
  Returns the list of user_favorites.

  ## Examples

      iex> list_user_favorites()
      [%UsersFavorites{}, ...]

  """
  def list_user_favorites do
    Repo.all(UserFavorites)
  end

  @doc """
  Gets a single users_favorites.

  Raises `Ecto.NoResultsError` if the Users favorites does not exist.

  ## Examples

      iex> get_users_favorites!(123)
      %UsersFavorites{}

      iex> get_users_favorites!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_favorites!(id), do: Repo.get!(UserFavorites, id)

  @doc """
  Creates a users_favorites.

  ## Examples

      iex> create_users_favorites(%{field: value})
      {:ok, %UsersFavorites{}}

      iex> create_users_favorites(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_favorites(attrs \\ %{}) do
    %UserFavorites{}
    |> UserFavorites.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a users_favorites.

  ## Examples

      iex> update_users_favorites(users_favorites, %{field: new_value})
      {:ok, %UsersFavorites{}}

      iex> update_users_favorites(users_favorites, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_favorites(%UserFavorites{} = user_favorites, attrs) do
    user_favorites
    |> UserFavorites.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a users_favorites.

  ## Examples

      iex> delete_users_favorites(users_favorites)
      {:ok, %UsersFavorites{}}

      iex> delete_users_favorites(users_favorites)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_favorites(%UserFavorites{} = user_favorites) do
    Repo.delete(user_favorites)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users_favorites changes.

  ## Examples

      iex> change_users_favorites(users_favorites)
      %Ecto.Changeset{data: %UsersFavorites{}}

  """
  def change_user_favorites(%UserFavorites{} = user_favorites, attrs \\ %{}) do
    UserFavorites.changeset(user_favorites, attrs)
  end

  alias Hello.Favorites.FavoriteItem

  @doc """
  Returns the list of favorite_items.

  ## Examples

      iex> list_favorite_items()
      [%FavoriteItem{}, ...]

  """
  def list_favorite_items do
    Repo.all(FavoriteItem)
  end

  @doc """
  Gets a single favorite_item.

  Raises `Ecto.NoResultsError` if the Favorite item does not exist.

  ## Examples

      iex> get_favorite_item!(123)
      %FavoriteItem{}

      iex> get_favorite_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_favorite_item!(id), do: Repo.get!(FavoriteItem, id)

  @doc """
  Creates a favorite_item.

  ## Examples

      iex> create_favorite_item(%{field: value})
      {:ok, %FavoriteItem{}}

      iex> create_favorite_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_favorite_item(attrs \\ %{}) do
    %FavoriteItem{}
    |> FavoriteItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a favorite_item.

  ## Examples

      iex> update_favorite_item(favorite_item, %{field: new_value})
      {:ok, %FavoriteItem{}}

      iex> update_favorite_item(favorite_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_favorite_item(%FavoriteItem{} = favorite_item, attrs) do
    favorite_item
    |> FavoriteItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a favorite_item.

  ## Examples

      iex> delete_favorite_item(favorite_item)
      {:ok, %FavoriteItem{}}

      iex> delete_favorite_item(favorite_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_favorite_item(%FavoriteItem{} = favorite_item) do
    Repo.delete(favorite_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking favorite_item changes.

  ## Examples

      iex> change_favorite_item(favorite_item)
      %Ecto.Changeset{data: %FavoriteItem{}}

  """
  def change_favorite_item(%FavoriteItem{} = favorite_item, attrs \\ %{}) do
    FavoriteItem.changeset(favorite_item, attrs)
  end

  def get_favorite_item_by_uuid(user_uuid, phone_id) do
    favorites = get_favorites_by_user_uuid(user_uuid)

    query =
      from(f in FavoriteItem,
        where: f.user_favorites_id == ^favorites.id and f.phone_id == ^phone_id
      )

    Repo.one(query)
  end

  def add_or_delete_favorite_item(user_uuid, phone_id) do
    phone = Catalog.get_smartphone(phone_id)

    favorites = get_favorites_by_user_uuid(user_uuid)

    Repo.transaction(fn ->
      query =
        from(f in FavoriteItem,
          where: f.user_favorites_id == ^favorites.id and f.phone_id == ^phone_id
        )

      case Repo.one(query) do
        nil ->
          %FavoriteItem{}
          |> FavoriteItem.changeset(%{})
          |> Ecto.Changeset.put_assoc(:user_favorites, favorites)
          |> Ecto.Changeset.put_assoc(:phone, phone)
          |> Repo.insert()

          :add

        _ ->
          remove_item_from_favorite(user_uuid, phone_id)
          :delete
      end
    end)
  end

  def remove_item_from_favorite(user_uuid, phone_id) do
    favorites = get_favorites_by_user_uuid(user_uuid)

    {1, _} =
      Repo.delete_all(
        from(i in FavoriteItem,
          where: i.user_favorites_id == ^favorites.id,
          where: i.phone_id == ^phone_id
        )
      )

    :ok
  end
end
