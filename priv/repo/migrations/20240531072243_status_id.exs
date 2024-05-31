defmodule Hello.Repo.Migrations.StatusId do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :status_id, references(:statuses)
    end
  end
end
