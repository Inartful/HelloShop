defmodule Hello.Catalog.Smartphones.Screen do
  use Ecto.Schema
  import Ecto.Changeset

  schema "screens" do
    field :size, :string
    field :resolution, :string
    field :type, :string
    field :refresh_rate, :string

    has_one :specs, Hello.Catalog.Smartphones.Spec

    timestamps()
  end

  @doc false
  def changeset(screen, attrs \\ %{}) do
    screen
    |> cast(attrs, [:size, :resolution, :type, :refresh_rate])
    |> validate_required([:size, :resolution, :type, :refresh_rate])
  end
end
