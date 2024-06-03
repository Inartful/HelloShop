# Script for populating the database. You can run it as:

#     mix run priv/repo/seeds.exs

# Inside the script, you can read and write to any of your
# repositories directly:

#     Hello.Repo.insert!(%Hello.SomeSchema{})

# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# for title <- ["Smartphones", "Gadgets", "Accessories"] do
#   {:ok, _} = Hello.Catalog.create_category(%{title: title})
# end

# statuses = ["Pending", "Processing", "Completed", "Cancelled"]

# for status <- statuses do
#   {:ok, _} = Hello.Orders.create_status(%{name: status})
# end

alias Hello.Repo

alias Hello.Catalog.Smartphones.{
  Smartphone,
  Processor,
  GPU,
  Screen,
  MainCamera,
  FrontCamera,
  OperationSystem,
  Dimensions,
  Smartphone,
  Spec
}

processor =
  Processor.changeset(%Processor{
    name: "Snapdragon 888",
    manufacturer: "Qualcomm",
    cores: 8,
    clock_speed: "2.84 GHz"
  })

gpu = GPU.changeset(%GPU{name: "Adreno 660", manufacturer: "Qualcomm"})

screen =
  Screen.changeset(%Screen{
    size: "6.7 inches",
    resolution: "1440 x 3200 pixels",
    type: "AMOLED",
    refresh_rate: "120 Hz"
  })

main_camera =
  MainCamera.changeset(%MainCamera{
    resolution: "108 MP",
    features: "OIS, PDAF, Laser AF"
  })

front_camera =
  FrontCamera.changeset(%FrontCamera{
    resolution: "40 MP",
    features: "Dual video call, Auto-HDR"
  })

operation_system = OperationSystem.changeset(%OperationSystem{name: "Android 12"})

dimensions =
  Dimensions.changeset(%Dimensions{length: 160.1, width: 75.6, depth: 8.7})

spec_changeset =
  Spec.changeset(
    %Spec{},
    %{
      weight: 180.5,
      additional_features: "Water and dust resistant (IP68)",
      storage: 256,
      ram: 12,
      battery: 4500
    }
  )

spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :processor, processor)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :gpu, gpu)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :screen, screen)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :main_camera, main_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :front_camera, front_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :operation_system, operation_system)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :dimensions, dimensions)

smartphone_changeset =
  Smartphone.changeset(
    %Smartphone{},
    %{
      name: "Example Smartphone",
      description: "This is an example smartphone",
      brand: "Example Brand"
    }
  )

smartphone_changeset =
  Ecto.Changeset.put_assoc(smartphone_changeset, :spec, spec_changeset)

case Hello.Repo.insert(smartphone_changeset) do
  {:ok, _} -> IO.puts("Smartphone inserted successfully")
  {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting smartphone:")
end
