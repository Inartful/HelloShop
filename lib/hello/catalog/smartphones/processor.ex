defmodule Hello.Catalog.Smartphones.Processor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "processors" do
    field :name, :string
    field :manufacturer, :string
    field :cores, :integer
    field :clock_speed, :string

    has_many :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(processor, attrs \\ %{}) do
    processor
    |> cast(attrs, [:name, :manufacturer, :cores, :clock_speed])
    |> validate_required([:name, :manufacturer, :cores, :clock_speed])
  end
end
