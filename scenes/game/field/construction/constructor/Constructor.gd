extends Node2D

var electricity_capacity = 100
var electricity_production = 10
var electricity = 0

var dupe

func get_selector_ui():
	if (!dupe || !dupe.get_ref()): dupe = weakref( $selector_ui.duplicate() )
	return dupe.get_ref()

func _ready():
	reveal()

func reveal():
	field_service.fog(global_position, construction_service.meta.constructor.fog_radius)
	field_service.reveal(global_position, construction_service.meta.constructor.reveal_radius)

func _on_production_timer_timeout():
	var new_electricity = clamp(electricity + electricity_production, 0, electricity_capacity)
	var change = new_electricity - electricity
	inventory_service.add_item('electricity', change)
	electricity += change
	if (dupe && dupe.get_ref()): dupe.get_ref().get_node("current_electricity/margin2/value").set_text(String(electricity))
