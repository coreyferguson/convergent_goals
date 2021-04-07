extends NinePatchRect

var InventoryListingItemScene = preload("res://scenes/game/field/inventory_view/InventoryListingItem.tscn")

onready var listing_node = $margin/scroll/listing

func _ready():
	inventory_service.connect("items_changed", self, "_on_inventory_items_changed")
	_render_inventory_items()

func _on_inventory_items_changed(action, item_name):
	_render_inventory_items()

func _render_inventory_items():
	var existing_items = listing_node.get_children()
	for existing_item in existing_items: existing_item.queue_free()
	for item_name in inventory_service.inventory:
		var inst = InventoryListingItemScene.instance()
		inst.item_name = item_name
		inst.quantity = inventory_service.inventory[item_name].quantity
		listing_node.add_child(inst)
