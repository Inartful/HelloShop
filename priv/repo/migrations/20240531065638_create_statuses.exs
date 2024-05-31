defmodule Hello.Repo.Migrations.CreateStatuses do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
