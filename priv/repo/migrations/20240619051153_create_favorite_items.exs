defmodule Hello.Repo.Migrations.CreateFavoriteItems do
  use Ecto.Migration

  def change do
    create table(:favorite_items) do
      add :user_favorites_id, references(:user_favorites, on_delete: :delete_all)
      add :phone_id, references(:smartphones, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:favorite_items, [:phone_id])
    create unique_index(:favorite_items, [:user_favorites_id, :phone_id])
  end
end
