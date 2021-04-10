extends Node

var Inventory = preload("res://scenes/game/field/build/capabilities/Inventory.gd")

var inventory = Inventory.new()
var metadata = {}

func add_item(item):

	return inventory.add_item(item)

func add_items(items):
	return inventory.add_items(items)

func get_item(name):
	return inventory.get_item(name)

func get_item_quantity(name):
	return inventory.get_item_quantity(name)

func has_items(items):
	return inventory.has_items(items)

func produce():
	for name in metadata:
		var pmd = metadata[name]
		var imd = inventory.get_metadata(name)
		if pmd.quantity + get_item_quantity(name) > imd.capacity: continue
		if inventory.can_afford(pmd.costs):
			inventory.add_items(pmd.costs)
			inventory.add_item({ 'name': name, 'quantity': pmd.quantity })

func remove_metadata(name):
	inventory.remove_metadata(name)
	metadata.erase(name)

func set_metadata(name, item_metadata, production_metadata):
	inventory.set_metadata(name, item_metadata)
	metadata[name] = production_metadata
