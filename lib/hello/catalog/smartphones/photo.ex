defmodule Hello.Catalog.Smartphones.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :path, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs \\ %{}) do
    category
    |> cast(attrs, [:path])
    |> validate_required([:path])
    |> unique_constraint(:path)
  end
end
