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

    create unique_index(:gpu, [:name])

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

    create unique_index(:processors, [:name])

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

    create unique_index(:operation_systems, [:name])

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

    create table(:colors) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:colors, [:title])

    create table(:smartphone_colors, primary_key: false) do
      add :color_id, references(:colors, on_delete: :delete_all)
      add :smartphone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:smartphone_colors, [:color_id])
    create unique_index(:smartphone_colors, [:smartphone_id, :color_id])

    create table(:materials) do
      add :title, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:materials, [:title])

    create table(:smartphone_materials, primary_key: false) do
      add :material_id, references(:materials, on_delete: :delete_all)
      add :smartphone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:smartphone_materials, [:material_id])
    create unique_index(:smartphone_materials, [:smartphone_id, :material_id])

    create table(:photos) do
      add :path, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:photos, [:path])

    create table(:smartphone_photos, primary_key: false) do
      add :photo_id, references(:photos, on_delete: :delete_all)
      add :smartphone_id, references(:smartphones, on_delete: :delete_all)
    end

    create index(:smartphone_photos, [:photo_id])
    create unique_index(:smartphone_photos, [:smartphone_id, :photo_id])

    alter table(:smartphones) do
      add :views, :integer
      add :price, :integer
      add :amount, :integer
    end
  end
end
