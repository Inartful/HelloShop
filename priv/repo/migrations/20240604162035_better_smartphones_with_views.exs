defmodule Hello.Repo.Migrations.BetterSmartphonesWithViews do
  use Ecto.Migration

  def change do
    alter table(:smartphones) do
      add :views, :integer
    end
  end
end
