order = Hello.Orders.get_order!("a07dcd80-d424-4e5c-b378-2268dda000ff", 1)

item =
  Enum.find(order.line_items, fn item ->
    item.phone_id == 1
  end)

new_quantity = item.quantity + String.to_integer("1")

IO.inspect(new_quantity)
