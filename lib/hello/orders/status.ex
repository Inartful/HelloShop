defmodule Hello.Orders.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statuses" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
