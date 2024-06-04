defmodule Hello.Repo.Migrations.BetterSmartphones_II do
  use Ecto.Migration

  def change do
    create table(:materials) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:materials, [:title])

    create table(:smartphone_materials, primary_key: false) do
      add :material_id, references(:materials, on_delete: :delete_all)
      add :smartphone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:smartphone_materials, [:material_id])
    create unique_index(:smartphone_materials, [:smartphone_id, :material_id])
  end
end
