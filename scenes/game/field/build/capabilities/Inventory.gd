extends Node

signal items_changed(action, item_name)

var metadata = {}
var data = {}

func add_item(item):
	if item.quantity == 0: return null
	if !metadata.has(item.name): return item
	var current_quantity = get_item_quantity(item.name)
	var new_quantity = clamp(current_quantity + item.quantity, 0, metadata[item.name].capacity)
	var quantity_added = new_quantity - current_quantity
	if quantity_added == 0: return null
	var remainder = new_quantity - get_item_quantity(item.name)
	if data.has(item.name): data[item.name].quantity = new_quantity
	else: data[item.name] = { 'name': name, 'quantity': new_quantity }
	inventory_service.add_item(item.name, quantity_added)
	emit_signal('items_changed', item.name)
	if remainder == 0: return null
	else: return { 'name': item.name, 'quantity': remainder }

func add_items(items):
	var remainders = []
	for item in items:
		var remainder = add_item(item)
		if remainder: remainders.push_back(remainder)
	return remainders

func can_afford(items):
	for item in items:
		if !data.has(item.name): return false
		if data[item.name].quantity < item.quantity * -1: return false
	return true

func get_item(name):
	return data[name]

func get_item_quantity(name):
	if data.has(name): return data[name].quantity
	else: return 0

func get_metadata(name):
	return metadata[name]

func remove_metadata(name):
	metadata.erase(name)
	if data[name]: inventory_service.add_item(name, data[name].quantity * -1)

func set_metadata(name, md):
	metadata[name] = md

