extends Node

signal items_changed(action, item_name)

export (Dictionary) var inventory = {}

func _ready():
	_reset()

func _reset():
	pass
	
func add_item(item_name, quantity):
	if inventory.has(item_name): 
		inventory[item_name].quantity += quantity
		assert(quantity >= 0, "ERROR: Attempted to remove a larger quantity than currently available.")
		emit_signal('items_changed', 'update', item_name)
	else: 
		inventory[item_name] = { 'name': item_name, 'quantity': quantity }
		emit_signal('items_changed', 'create', item_name)
