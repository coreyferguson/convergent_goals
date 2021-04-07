extends Node2D

var Producer = preload("res://scenes/game/field/build/capabilities/Producer.gd")
var producer = Producer.new()

var dupe

func _init():
	for name in build_service.meta.constructor.productions:
		var p = build_service.meta.constructor.productions[name]
		var item_metadata = { 'capacity': p.capacity, 'name': name }
		var production_metadata = { 'costs': p.costs, 'name': name, 'quantity': p.quantity }
		producer.set_metadata(name, item_metadata, production_metadata)

func get_selector_ui():
	if (!dupe || !dupe.get_ref()): dupe = weakref( $selector_ui.duplicate() )
	return dupe.get_ref()

func _ready():
	reveal()

func reveal():
	field_service.fog(global_position, build_service.meta.constructor.fog_radius)
	field_service.reveal(global_position, build_service.meta.constructor.reveal_radius)

func _on_production_timer_timeout():
	producer.produce()
	_update_ui()

func _set_ui_value(label, value):
	$selector_ui.get_node(label + '/margin2/value').set_text(String(value))
	if (dupe && dupe.get_ref()): dupe.get_ref().get_node(label + '/margin2/value').set_text(String(value))

func _update_ui():
	_set_ui_value('electricity', producer.get_item_quantity('electricity'))
	_set_ui_value('construction_bot', producer.get_item_quantity('construction_bot'))
	_set_ui_value('iron', producer.get_item_quantity('iron'))

func add_item(item):
	return producer.add_item(item)
