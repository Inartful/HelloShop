defmodule HelloWeb.PageController do
  use HelloWeb, :controller
  alias Hello.Catalog
  alias Hello.Helper

  def home(conn, _params) do
    phones = Catalog.list_four_smartphones()

    list_phones =
      Enum.reduce(phones, [], fn phone, list ->
        map = %{}
        [first_photo | _] = phone.photos

        have? =
          if phone.amount > 0 do
            true
          else
            false
          end

        map =
          map
          |> Map.put(:id, phone.id)
          |> Map.put(:path, first_photo.path <> ".png")
          |> Map.put(:name, phone.name)
          |> Map.put(:price, Helper.format_with_spaces(phone.price) <> "₸")
          |> Map.put(:have?, have?)

        list ++ [map]
      end)

    render(conn, :home, phones: list_phones)
  end

  def show(conn, %{"id" => id}) do
    phone =
      id
      |> Catalog.get_smartphone()
      |> Catalog.inc_page_views()

    render(conn, :show, phone: phone)
  end
end
