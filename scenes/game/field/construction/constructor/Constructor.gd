extends Node2D

var electricity_capacity = 100
var electricity_production = 10
var electricity = 0

var construction_bot_capacity = 100
var construction_bot_production = 1
var construction_bots = 0
var iron_per_construction_bot = 1

var iron_capacity = 100
var iron = 5

var dupe

func get_selector_ui():
	if (!dupe || !dupe.get_ref()): dupe = weakref( $selector_ui.duplicate() )
	return dupe.get_ref()

func _ready():
	_set_ui_value('electricity', electricity)
	_set_ui_value('construction_bots', construction_bots)
	_set_ui_value('iron', iron)
	inventory_service.add_item('iron', iron)
	reveal()

func reveal():
	field_service.fog(global_position, construction_service.meta.constructor.fog_radius)
	field_service.reveal(global_position, construction_service.meta.constructor.reveal_radius)

func _on_production_timer_timeout():
	# electricity
	var new_electricity = clamp(electricity + electricity_production, 0, electricity_capacity)
	var change = new_electricity - electricity
	inventory_service.add_item('electricity', change)
	electricity += change
	_set_ui_value('electricity', electricity)
	
	# construction bots
	var num_cbots_until_full = clamp(construction_bots + construction_bot_production, 0, construction_bot_capacity) - construction_bots
	var construction_bots_purchased = min(change, iron)
	inventory_service.add_item('construction_bot', construction_bots_purchased)
	construction_bots += construction_bots_purchased
	iron -= construction_bots_purchased
	_set_ui_value('construction_bots', construction_bots)
	_set_ui_value('iron', iron)
	inventory_service.add_item('iron', construction_bots_purchased * -1)
	
#	construction_bots += construction_bots_purchased
#	_set_ui_value('construction_bots', construction_bots)
#	_set_ui_value('iron', iron)

func _set_ui_value(label, value):
	$selector_ui.get_node(label + '/margin2/value').set_text(String(value))
	if (dupe && dupe.get_ref()): dupe.get_ref().get_node(label + '/margin2/value').set_text(String(value))
