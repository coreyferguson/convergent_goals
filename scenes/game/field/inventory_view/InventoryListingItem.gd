extends HBoxContainer

export (String) var item_name setget _set_item_name
export (int) var quantity setget _set_quantity

func _set_item_name(new_item_name):
	item_name = new_item_name
	print('new_item_name: ' + str(new_item_name))
	$left/item_name.text = str(new_item_name)

func _set_quantity(new_quantity):
	quantity = new_quantity
	$right/quantity.text = str(new_quantity)
