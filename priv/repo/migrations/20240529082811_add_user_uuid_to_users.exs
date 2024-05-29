defmodule Hello.Repo.Migrations.AddUserUuidToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :user_uuid, :uuid
    end
  end
end
