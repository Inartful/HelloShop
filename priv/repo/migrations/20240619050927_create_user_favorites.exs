defmodule Hello.Repo.Migrations.CreateUserFavorites do
  use Ecto.Migration

  def change do
    create table(:user_favorites) do
      add :user_uuid, :uuid

      timestamps(type: :utc_datetime)
    end

    create unique_index(:user_favorites, [:user_uuid])
  end
end
