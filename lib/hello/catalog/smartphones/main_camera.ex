defmodule Hello.Catalog.Smartphones.MainCamera do
  use Ecto.Schema
  import Ecto.Changeset

  schema "main_cameras" do
    field :resolution, :string
    field :features, :string

    has_one :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(main_camera, attrs \\ %{}) do
    main_camera
    |> cast(attrs, [:resolution, :features])
    |> validate_required([:resolution, :features])
  end
end
