defmodule Hello.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Orders.Status

  schema "orders" do
    field :user_uuid, Ecto.UUID
    field :total_price, :decimal
    belongs_to :status, Status, foreign_key: :status_id

    has_many :line_items, Hello.Orders.LineItem
    has_many :phones, through: [:line_items, :phone]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:user_uuid, :total_price])
    |> validate_required([:user_uuid, :total_price])
  end
end
