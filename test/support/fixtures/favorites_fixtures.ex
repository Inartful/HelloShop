defmodule Hello.FavoritesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Favorites` context.
  """

  @doc """
  Generate a unique users_favorites user_uuid.
  """
  def unique_users_favorites_user_uuid do
    raise "implement the logic to generate a unique users_favorites user_uuid"
  end

  @doc """
  Generate a users_favorites.
  """
  def users_favorites_fixture(attrs \\ %{}) do
    {:ok, users_favorites} =
      attrs
      |> Enum.into(%{
        user_uuid: unique_users_favorites_user_uuid()
      })
      |> Hello.Favorites.create_users_favorites()

    users_favorites
  end

  @doc """
  Generate a favorite_item.
  """
  def favorite_item_fixture(attrs \\ %{}) do
    {:ok, favorite_item} =
      attrs
      |> Enum.into(%{

      })
      |> Hello.Favorites.create_favorite_item()

    favorite_item
  end
end
