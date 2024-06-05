defmodule Hello.Repo.Migrations.SmartphonePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :path, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:photos, [:path])

    create table(:smartphone_photos, primary_key: false) do
      add :photo_id, references(:photos, on_delete: :delete_all)
      add :smartphone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:smartphone_photos, [:photo_id])
    create unique_index(:smartphone_photos, [:smartphone_id, :photo_id])
  end
end
