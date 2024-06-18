alias Hello.Repo
import Ecto.Query

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
  Spec,
  Color,
  Material,
  Photo
}

for title <- ["Смартфоны", "Гаджеты", "Аксессуары"] do
  {:ok, _} = Hello.Catalog.create_category(%{title: title})
end

statuses = [
  "Начат",
  "Создан",
  "Обрабатывается",
  "Ожидает оплаты",
  "Оплачен",
  "Готов к отправке",
  "Отправлен",
  "В пути",
  "Доставлен",
  "Отменен",
  "Возвращен",
  "Возврат средств выполнен",
  "Неудачная доставка",
  "Ожидает поступления товара",
  "Готов к самовывозу"
]

for status <- statuses do
  {:ok, _} = Hello.Orders.create_status(%{name: status})
end

for title <- ["Черный", "Белый", "Синий", "Зеленый", "Крассный", "Золотой", "Стальной"] do
  %Hello.Catalog.Smartphones.Color{}
  |> Hello.Catalog.Smartphones.Color.changeset(%{title: title})
  |> Hello.Repo.insert()
end

for title <- ["Сталь", "Пластик", "Стекло", "Титан", "Золото"] do
  %Hello.Catalog.Smartphones.Material{}
  |> Hello.Catalog.Smartphones.Material.changeset(%{title: title})
  |> Hello.Repo.insert()
end

for path <- [
      "samsung_galaxy_s24_front",
      "apple_iphone_15_pro_max_front",
      "google_pixel_8_pro",
      "one_plus_12r"
    ] do
  %Hello.Catalog.Smartphones.Photo{}
  |> Hello.Catalog.Smartphones.Photo.changeset(%{path: path})
  |> Hello.Repo.insert()
end

###########################
# Samsung
###########################

processor =
  Processor.changeset(%Processor{
    name: "Snapdragon 8 Gen3",
    manufacturer: "Qualcomm",
    cores: 8,
    clock_speed: "3.33 GHz"
  })

gpu = GPU.changeset(%GPU{name: "Adreno 660", manufacturer: "Qualcomm"})

screen =
  Screen.changeset(%Screen{
    size: "6.8 inches",
    resolution: "1440 x 3200 pixels",
    type: "Dynamic AMOLED 2X",
    refresh_rate: "120 Hz"
  })

main_camera =
  MainCamera.changeset(%MainCamera{
    resolution: "200MP + 50MP + 10MP + 12MP ",
    features: "OIS, PDAF, Laser AF"
  })

front_camera =
  FrontCamera.changeset(%FrontCamera{
    resolution: "12MP",
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
      storage: 512,
      ram: 12,
      battery: 5000
    }
  )

spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :processor, processor)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :gpu, gpu)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :screen, screen)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :main_camera, main_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :front_camera, front_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :operation_system, operation_system)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :dimensions, dimensions)

colors_ids = [1, 2, 7]
colors = Repo.all(from c in Color, where: c.id in ^colors_ids)

materials_ids = [1, 3]
materials = Repo.all(from c in Material, where: c.id in ^materials_ids)

photoes_ids = [1]
photos = Repo.all(from c in Photo, where: c.id in ^photoes_ids)

smartphone_changeset =
  Smartphone.changeset(
    %Smartphone{},
    %{
      name: "Samsung Galaxy S24 Ultra 12",
      description: "This is an example smartphone",
      brand: "Samsung",
      views: 0,
      price: 684_241,
      amount: 100
    }
  )

smartphone_changeset =
  Ecto.Changeset.put_assoc(smartphone_changeset, :spec, spec_changeset)
  |> Ecto.Changeset.put_assoc(:colors, colors)
  |> Ecto.Changeset.put_assoc(:materials, materials)
  |> Ecto.Changeset.put_assoc(:photos, photos)

case Hello.Repo.insert(smartphone_changeset) do
  {:ok, _} -> IO.puts("Smartphone inserted successfully")
  {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting smartphone:")
end

###################
# Iphone
###################

processor =
  Processor.changeset(%Processor{
    name: "A16 Bionic",
    manufacturer: "Apple",
    cores: 6,
    clock_speed: "3.0 GHz"
  })

gpu = GPU.changeset(%GPU{name: "Apple GPU", manufacturer: "Apple"})

screen =
  Screen.changeset(%Screen{
    size: "6.7 inches",
    resolution: "1284 x 2778 pixels",
    type: "Super Retina XDR OLED",
    refresh_rate: "ProMotion 120 Hz"
  })

main_camera =
  MainCamera.changeset(%MainCamera{
    resolution: "12MP + 12MP + 12MP",
    features: "OIS, HDR, Night mode"
  })

front_camera =
  FrontCamera.changeset(%FrontCamera{
    resolution: "12MP",
    features: "HDR, Face detection, Portrait mode"
  })

operation_system = OperationSystem.changeset(%OperationSystem{name: "iOS 16"})

dimensions =
  Dimensions.changeset(%Dimensions{length: 160.8, width: 78.1, depth: 7.7})

spec_changeset =
  Spec.changeset(
    %Spec{},
    %{
      weight: 228,
      additional_features: "Face ID, Water and dust resistant (IP68)",
      storage: 256,
      ram: 8,
      battery: 4352
    }
  )

spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :processor, processor)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :gpu, gpu)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :screen, screen)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :main_camera, main_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :front_camera, front_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :operation_system, operation_system)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :dimensions, dimensions)

colors_ids = [1, 2]
colors = Repo.all(from c in Color, where: c.id in ^colors_ids)

materials_ids = [1, 3]
materials = Repo.all(from c in Material, where: c.id in ^materials_ids)

photoes_ids = [2]
photos = Repo.all(from c in Photo, where: c.id in ^photoes_ids)

smartphone_changeset =
  Smartphone.changeset(
    %Smartphone{},
    %{
      name: "Apple iPhone 15 Pro Max",
      description: "This is an example smartphone",
      brand: "Apple",
      views: 0,
      price: 684_241,
      amount: 100
    }
  )

smartphone_changeset =
  Ecto.Changeset.put_assoc(smartphone_changeset, :spec, spec_changeset)
  |> Ecto.Changeset.put_assoc(:colors, colors)
  |> Ecto.Changeset.put_assoc(:materials, materials)
  |> Ecto.Changeset.put_assoc(:photos, photos)

case Hello.Repo.insert(smartphone_changeset) do
  {:ok, _} -> IO.puts("Smartphone inserted successfully")
  {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting smartphone:")
end

###################
# Pixel
###################

processor =
  Processor.changeset(%Processor{
    name: "Google Tensor G3",
    manufacturer: "Google",
    cores: 8,
    clock_speed: "2.85 GHz"
  })

gpu = GPU.changeset(%GPU{name: "Mali-G710", manufacturer: "ARM"})

screen =
  Screen.changeset(%Screen{
    size: "6.7 inches",
    resolution: "1440 x 3120 pixels",
    type: "LTPO OLED",
    refresh_rate: "120 Hz"
  })

main_camera =
  MainCamera.changeset(%MainCamera{
    resolution: "50MP + 48MP + 12MP",
    features: "OIS, HDR, Night mode"
  })

front_camera =
  FrontCamera.changeset(%FrontCamera{
    resolution: "11MP",
    features: "HDR, Face detection, Portrait mode"
  })

operation_system = OperationSystem.changeset(%OperationSystem{name: "Android 14"})

dimensions =
  Dimensions.changeset(%Dimensions{length: 162.6, width: 76.5, depth: 8.8})

spec_changeset =
  Spec.changeset(
    %Spec{},
    %{
      weight: 213,
      additional_features: "Face ID, Water and dust resistant (IP68), Wireless charging",
      storage: 256,
      ram: 12,
      battery: 5000
    }
  )

spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :processor, processor)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :gpu, gpu)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :screen, screen)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :main_camera, main_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :front_camera, front_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :operation_system, operation_system)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :dimensions, dimensions)

colors_ids = [1, 2]
colors = Repo.all(from c in Color, where: c.id in ^colors_ids)

materials_ids = [1, 3]
materials = Repo.all(from c in Material, where: c.id in ^materials_ids)

photoes_ids = [3]
photos = Repo.all(from c in Photo, where: c.id in ^photoes_ids)

smartphone_changeset =
  Smartphone.changeset(
    %Smartphone{},
    %{
      name: "Google Pixel 8 Pro",
      description: "This is an example smartphone",
      brand: "Google",
      views: 0,
      price: 490_990,
      amount: 100
    }
  )

smartphone_changeset =
  Ecto.Changeset.put_assoc(smartphone_changeset, :spec, spec_changeset)
  |> Ecto.Changeset.put_assoc(:colors, colors)
  |> Ecto.Changeset.put_assoc(:materials, materials)
  |> Ecto.Changeset.put_assoc(:photos, photos)

case Hello.Repo.insert(smartphone_changeset) do
  {:ok, _} -> IO.puts("Smartphone inserted successfully")
  {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting smartphone:")
end

####################
# One Plus
####################

processor =
  Processor.changeset(%Processor{
    name: "Snapdragon 8+ Gen 1",
    manufacturer: "Qualcomm",
    cores: 8,
    clock_speed: "3.2 GHz"
  })

gpu = GPU.changeset(%GPU{name: "Adreno 730", manufacturer: "Qualcomm"})

screen =
  Screen.changeset(%Screen{
    size: "6.7 inches",
    resolution: "1080 x 2412 pixels",
    type: "Fluid AMOLED",
    refresh_rate: "120 Hz"
  })

main_camera =
  MainCamera.changeset(%MainCamera{
    resolution: "50MP + 8MP + 2MP",
    features: "OIS, HDR, Night mode"
  })

front_camera =
  FrontCamera.changeset(%FrontCamera{
    resolution: "16MP",
    features: "HDR, Face detection, Portrait mode"
  })

operation_system = OperationSystem.changeset(%OperationSystem{name: "Android 13"})

dimensions =
  Dimensions.changeset(%Dimensions{length: 163.1, width: 74.1, depth: 8.3})

spec_changeset =
  Spec.changeset(
    %Spec{},
    %{
      weight: 194,
      additional_features: "Fingerprint sensor, Water resistant (IP54), Fast charging",
      storage: 256,
      ram: 12,
      battery: 5000
    }
  )

spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :processor, processor)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :gpu, gpu)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :screen, screen)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :main_camera, main_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :front_camera, front_camera)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :operation_system, operation_system)
spec_changeset = Ecto.Changeset.put_assoc(spec_changeset, :dimensions, dimensions)

colors_ids = [1, 3, 4]
colors = Repo.all(from c in Color, where: c.id in ^colors_ids)

materials_ids = [2, 3, 4]
materials = Repo.all(from c in Material, where: c.id in ^materials_ids)

photoes_ids = [4]
photos = Repo.all(from c in Photo, where: c.id in ^photoes_ids)

smartphone_changeset =
  Smartphone.changeset(
    %Smartphone{},
    %{
      name: "OnePlus 12R",
      description: "This is an example smartphone",
      brand: "OnePlus",
      views: 0,
      price: 599_999,
      amount: 100
    }
  )

smartphone_changeset =
  Ecto.Changeset.put_assoc(smartphone_changeset, :spec, spec_changeset)
  |> Ecto.Changeset.put_assoc(:colors, colors)
  |> Ecto.Changeset.put_assoc(:materials, materials)
  |> Ecto.Changeset.put_assoc(:photos, photos)

case Hello.Repo.insert(smartphone_changeset) do
  {:ok, _} -> IO.puts("Smartphone inserted successfully")
  {:error, changeset} -> IO.inspect(changeset.errors, label: "Error inserting smartphone:")
end

# IO.inspect(Hello.Catalog.list_smartphones())
# sm = Hello.Catalog.list_smartphones()
# [first | _] = sm
# IO.inspect(first)
