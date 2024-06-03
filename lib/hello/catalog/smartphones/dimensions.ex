defmodule Hello.Catalog.Smartphones.Dimensions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dimensions" do
    field :length, :float
    field :width, :float
    field :depth, :float

    has_many :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(dimensions, attrs \\ %{}) do
    dimensions
    |> cast(attrs, [:length, :width, :depth])
    |> validate_required([:length, :width, :depth])
  end
end
