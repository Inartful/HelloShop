# for title <- ["Smartphones", "Gadgets", "Accessories"] do
#   {:ok, _} = Hello.Catalog.create_category(%{title: title})
# end

# for title <- ["Black", "White", "Blue", "Green", "Red", "Gold", "Steel"] do
#   %Hello.Catalog.Smartphones.Color{}
#   |> Hello.Catalog.Smartphones.Color.changeset(%{title: title})
#   |> Hello.Repo.insert()
# end

# for title <- ["Steel", "Plastic", "Glass", "Titanium", "Gold"] do
#   %Hello.Catalog.Smartphones.Material{}
#   |> Hello.Catalog.Smartphones.Material.changeset(%{title: title})
#   |> Hello.Repo.insert()
# end

# statuses = ["Pending", "Processing", "Completed", "Cancelled"]
# for status <- statuses do
#   {:ok, _} = Hello.Orders.create_status(%{name: status})
# end

# alias Hello.Repo
# import Ecto.Query

# alias Hello.Catalog.Smartphones.{
#   Smartphone,
#   Processor,
#   GPU,
#   Screen,
#   MainCamera,
#   FrontCamera,
#   OperationSystem,
#   Dimensions,
#   Smartphone,
#   Spec,
#   Color,
#   Material
# }

# processor =
#   Processor.changeset(%Processor{
#     name: "Snapdragon 8 Gen3",
#     manufacturer: "Qualcomm",
#     cores: 8,
#     clock_speed: "3.33 GHz"
#   })

# gpu = GPU.changeset(%GPU{name: "Adreno 660", manufacturer: "Qualcomm"})

# screen =
#   Screen.changeset(%Screen{
#     size: "6.8 inches",
#     resolution: "1440 x 3200 pixels",
#     type: "Dynamic AMOLED 2X",
#     refresh_rate: "120 Hz"
#   })

# main_camera =
#   MainCamera.changeset(%MainCamera{
#     resolution: "200 MP + 50 MP + 10 MP + 12 MP ",
#     features: "OIS, PDAF, Laser AF"
#   })

# front_camera =
#   FrontCamera.changeset(%FrontCamera{
#     resolution: "12 MP",
#     features: "Dual video call, Auto-HDR"
#   })

# operation_system = OperationSystem.changeset(%OperationSystem{name: "Android 12"})

# dimensions =
#   Dimensions.changeset(%Dimensions{length: 160.1, width: 75.6, depth: 8.7})

# spec_changeset =
#   Spec.changeset(
#     %Spec{},
#     %{
#       weight: 180.5,
#       additional_features: "Water and dust resistant (IP68)",
#       storage: 512,
#       ram: 12,
#       battery: 5000
#     }
#   )

# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :processor, processor)
# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :gpu, gpu)
# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :screen, screen)
# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :main_camera, main_camera)
# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :front_camera, front_camera)
# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :operation_system, operation_system)
# spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :dimensions, dimensions)

# colors_ids = [1, 2, 7]
# colors = Repo.all(from c in Color, where: c.id in ^colors_ids)

# materials_ids = [1, 3]
# materials = Repo.all(from c in Material, where: c.id in ^materials_ids)

# smartphone_changeset =
#   Smartphone.changeset(
#     %Smartphone{},
#     %{
#       name: "Samsung Galaxy S24 Ultra 12",
#       description: "This is an example smartphone",
#       brand: "Samsung"
#     }
#   )

# smartphone_changeset =
#   Ecto.Changeset.put_assoc(smartphone_changeset, :spec, spec_changeset)
#   |> Ecto.Changeset.put_assoc(:colors, colors)
#   |> Ecto.Changeset.put_assoc(:materials, materials)

# case Hello.Repo.insert(smartphone_changeset) do
#   {:ok, _} -> IO.puts("Smartphone inserted successfully")
#   {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting smartphone:")
# end

IO.inspect(Hello.Catalog.get_smartphone(1))
