defmodule Hello.Catalog.Smartphones.Material do
  use Ecto.Schema
  import Ecto.Changeset

  schema "materials" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs \\ %{}) do
    category
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
