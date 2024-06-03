defmodule Hello.Catalog.Smartphones.GPU do
  use Ecto.Schema
  import Ecto.Changeset

  schema "gpu" do
    field :name, :string
    field :manufacturer, :string

    has_many :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(gpu, attrs \\ %{}) do
    gpu
    |> cast(attrs, [:name, :manufacturer])
    |> validate_required([:name, :manufacturer])
  end
end
