extends Node

signal items_changed(action, item_name)

export (Dictionary) var inventory = {}

func _ready():
	_reset()

func _reset():
	pass
	
func add_item(item_name, quantity):
	if quantity == 0: return
	if inventory.has(item_name): 
		inventory[item_name].quantity += quantity
		assert(inventory[item_name].quantity >= 0, "ERROR: Attempted to remove a larger quantity than currently available.")
		if (inventory[item_name].quantity == 0): inventory.erase(item_name)
		emit_signal('items_changed', 'update', item_name)
	else:
		inventory[item_name] = { 'name': item_name, 'quantity': quantity }
		emit_signal('items_changed', 'create', item_name)
