defmodule Hello.Repo.Migrations.BetterSmartphones do
  use Ecto.Migration

  def change do
    create table(:colors) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:colors, [:title])

    create table(:smartphone_colors, primary_key: false) do
      add :color_id, references(:colors, on_delete: :delete_all)
      add :smartphone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:smartphone_colors, [:color_id])
    create unique_index(:smartphone_colors, [:smartphone_id, :color_id])
  end
end
