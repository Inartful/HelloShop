defmodule Hello.Catalog.Smartphones.FrontCamera do
  use Ecto.Schema
  import Ecto.Changeset

  schema "front_cameras" do
    field :resolution, :string
    field :features, :string

    has_one :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(front_camera, attrs \\ %{}) do
    front_camera
    |> cast(attrs, [:resolution, :features])
    |> validate_required([:resolution, :features])
  end
end
