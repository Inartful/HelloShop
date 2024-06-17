defmodule Hello.Repo.Migrations.CartRebuilding do
  use Ecto.Migration

  def change do
    drop unique_index(:cart_items, [:cart_id, :product_id])
    drop index(:cart_items, [:product_id])

    alter table(:cart_items) do
      remove :product_id
    end

    alter table(:cart_items) do
      add :phone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:cart_items, [:phone_id])
    create unique_index(:cart_items, [:cart_id, :phone_id])
  end
end
