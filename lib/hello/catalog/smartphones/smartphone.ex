defmodule Hello.Catalog.Smartphones.Smartphone do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Catalog.Smartphones.Spec

  schema "smartphones" do
    field :name, :string
    field :description, :string
    field :brand, :string
    belongs_to :spec, Spec

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, [:name, :description, :brand])
    |> validate_required([:name, :description, :brand])
  end
end
