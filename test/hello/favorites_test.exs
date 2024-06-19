defmodule Hello.FavoritesTest do
  use Hello.DataCase

  alias Hello.Favorites

  describe "user_favorites" do
    alias Hello.Favorites.UsersFavorites

    import Hello.FavoritesFixtures

    @invalid_attrs %{user_uuid: nil}

    test "list_user_favorites/0 returns all user_favorites" do
      users_favorites = users_favorites_fixture()
      assert Favorites.list_user_favorites() == [users_favorites]
    end

    test "get_users_favorites!/1 returns the users_favorites with given id" do
      users_favorites = users_favorites_fixture()
      assert Favorites.get_users_favorites!(users_favorites.id) == users_favorites
    end

    test "create_users_favorites/1 with valid data creates a users_favorites" do
      valid_attrs = %{user_uuid: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %UsersFavorites{} = users_favorites} = Favorites.create_users_favorites(valid_attrs)
      assert users_favorites.user_uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_users_favorites/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Favorites.create_users_favorites(@invalid_attrs)
    end

    test "update_users_favorites/2 with valid data updates the users_favorites" do
      users_favorites = users_favorites_fixture()
      update_attrs = %{user_uuid: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %UsersFavorites{} = users_favorites} = Favorites.update_users_favorites(users_favorites, update_attrs)
      assert users_favorites.user_uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_users_favorites/2 with invalid data returns error changeset" do
      users_favorites = users_favorites_fixture()
      assert {:error, %Ecto.Changeset{}} = Favorites.update_users_favorites(users_favorites, @invalid_attrs)
      assert users_favorites == Favorites.get_users_favorites!(users_favorites.id)
    end

    test "delete_users_favorites/1 deletes the users_favorites" do
      users_favorites = users_favorites_fixture()
      assert {:ok, %UsersFavorites{}} = Favorites.delete_users_favorites(users_favorites)
      assert_raise Ecto.NoResultsError, fn -> Favorites.get_users_favorites!(users_favorites.id) end
    end

    test "change_users_favorites/1 returns a users_favorites changeset" do
      users_favorites = users_favorites_fixture()
      assert %Ecto.Changeset{} = Favorites.change_users_favorites(users_favorites)
    end
  end

  describe "favorite_items" do
    alias Hello.Favorites.FavoriteItem

    import Hello.FavoritesFixtures

    @invalid_attrs %{}

    test "list_favorite_items/0 returns all favorite_items" do
      favorite_item = favorite_item_fixture()
      assert Favorites.list_favorite_items() == [favorite_item]
    end

    test "get_favorite_item!/1 returns the favorite_item with given id" do
      favorite_item = favorite_item_fixture()
      assert Favorites.get_favorite_item!(favorite_item.id) == favorite_item
    end

    test "create_favorite_item/1 with valid data creates a favorite_item" do
      valid_attrs = %{}

      assert {:ok, %FavoriteItem{} = favorite_item} = Favorites.create_favorite_item(valid_attrs)
    end

    test "create_favorite_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Favorites.create_favorite_item(@invalid_attrs)
    end

    test "update_favorite_item/2 with valid data updates the favorite_item" do
      favorite_item = favorite_item_fixture()
      update_attrs = %{}

      assert {:ok, %FavoriteItem{} = favorite_item} = Favorites.update_favorite_item(favorite_item, update_attrs)
    end

    test "update_favorite_item/2 with invalid data returns error changeset" do
      favorite_item = favorite_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Favorites.update_favorite_item(favorite_item, @invalid_attrs)
      assert favorite_item == Favorites.get_favorite_item!(favorite_item.id)
    end

    test "delete_favorite_item/1 deletes the favorite_item" do
      favorite_item = favorite_item_fixture()
      assert {:ok, %FavoriteItem{}} = Favorites.delete_favorite_item(favorite_item)
      assert_raise Ecto.NoResultsError, fn -> Favorites.get_favorite_item!(favorite_item.id) end
    end

    test "change_favorite_item/1 returns a favorite_item changeset" do
      favorite_item = favorite_item_fixture()
      assert %Ecto.Changeset{} = Favorites.change_favorite_item(favorite_item)
    end
  end
end
