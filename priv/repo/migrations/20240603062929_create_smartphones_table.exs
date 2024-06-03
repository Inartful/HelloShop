defmodule Hello.Repo.Migrations.CreateSmartphonesTable do
  use Ecto.Migration

  def change do
    create table(:dimensions) do
      add :length, :float
      add :width, :float
      add :depth, :float

      timestamps()
    end

    create table(:front_cameras) do
      add :resolution, :string
      add :features, :string

      timestamps()
    end

    create table(:gpu) do
      add :name, :string
      add :manufacturer, :string

      timestamps()
    end

    create table(:main_cameras) do
      add :resolution, :string
      add :features, :string

      timestamps()
    end

    create table(:processors) do
      add :name, :string
      add :manufacturer, :string
      add :cores, :integer
      add :clock_speed, :string

      timestamps()
    end

    create table(:screens) do
      add :size, :string
      add :resolution, :string
      add :type, :string
      add :refresh_rate, :string

      timestamps()
    end

    create table(:operation_systems) do
      add :name, :string
      add :version, :string

      timestamps()
    end

    create table(:specs) do
      add :weight, :float
      add :additional_features, :string
      add :storage, :integer
      add :ram, :integer
      add :battery, :integer

      add :processor_id, references(:processors, on_delete: :delete_all)
      add :gpu_id, references(:gpu, on_delete: :delete_all)
      add :screen_id, references(:screens, on_delete: :delete_all)
      add :main_camera_id, references(:main_cameras, on_delete: :delete_all)
      add :front_camera_id, references(:front_cameras, on_delete: :delete_all)
      add :operation_system_id, references(:operation_systems, on_delete: :delete_all)
      add :dimensions_id, references(:dimensions, on_delete: :delete_all)

      timestamps()
    end

    create table(:smartphones) do
      add :name, :string
      add :description, :string
      add :brand, :string
      add :spec_id, references(:specs, on_delete: :delete_all)

      timestamps()
    end
  end
end
