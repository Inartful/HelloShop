defmodule Hello.Catalog.Smartphones.Smartphone do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hello.Catalog.Smartphones.{Spec, Color, Material}

  schema "smartphones" do
    field :name, :string
    field :description, :string
    field :brand, :string
    field :views, :integer
    belongs_to :spec, Spec

    many_to_many :colors, Color, join_through: "smartphone_colors", on_replace: :delete
    many_to_many :materials, Material, join_through: "smartphone_materials", on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, [:name, :description, :brand])
    |> validate_required([:name, :description, :brand])
  end
end
