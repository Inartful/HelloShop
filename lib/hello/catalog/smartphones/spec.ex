defmodule Hello.Catalog.Smartphones.Spec do
  use Ecto.Schema
  import Ecto.Changeset

  alias Hello.Catalog.Smartphones.{
    Smartphone,
    Processor,
    GPU,
    Screen,
    MainCamera,
    FrontCamera,
    OperationSystem,
    Dimensions
  }

  schema "specs" do
    field :weight, :float
    field :additional_features, :string
    field :storage, :integer
    field :ram, :integer
    field :battery, :integer

    belongs_to :processor, Processor
    belongs_to :gpu, GPU
    belongs_to :screen, Screen
    belongs_to :main_camera, MainCamera
    belongs_to :front_camera, FrontCamera
    belongs_to :operation_system, OperationSystem
    belongs_to :dimensions, Dimensions

    has_one :smartphones, Smartphone

    timestamps()
  end

  @doc false
  def changeset(product, attrs \\ %{}) do
    product
    |> cast(attrs, [
      :weight,
      :additional_features,
      :ram,
      :storage,
      :battery
    ])
    |> validate_required([
      :weight,
      :additional_features,
      :ram,
      :storage,
      :battery
    ])
  end
end
