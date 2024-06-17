defmodule Hello.Repo.Migrations.OrderRebuilding do
  use Ecto.Migration

  def change do
    drop unique_index(:order_line_items, [:order_id])
    drop index(:order_line_items, [:product_id])

    alter table(:order_line_items) do
      remove :product_id
    end

    alter table(:order_line_items) do
      add :phone_id, references(:smartphones, on_delete: :nothing)
    end

    create index(:order_line_items, [:order_id])
    create index(:order_line_items, [:phone_id])
  end
end
