defmodule Hello.Catalog.Smartphones.OperationSystem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "operation_systems" do
    field :name, :string
    has_many :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(os, attrs \\ %{}) do
    os
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
