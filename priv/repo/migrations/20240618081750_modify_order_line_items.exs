defmodule Hello.Repo.Migrations.ModifyOrderLineItems do
  use Ecto.Migration

  def change do
    alter table(:order_line_items) do
      modify :order_id, references(:orders, on_delete: :delete_all),
        from: references(:orders, on_delete: :nothing)
    end
  end
end
