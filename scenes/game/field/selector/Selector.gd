extends Node2D

onready var tile_indicator = $tile_indicator
onready var selected = $canvas/margin/hbox/selected

func _unhandled_input(event):
	if event.is_action_pressed("select_point"):
		var global_position = get_global_mouse_position()
		var v = field_service.tile_map.world_to_map(global_position)
		tile_indicator.visible = true
		var global_position_of_tile = field_service.tile_map.map_to_world(v) + field_service.tile_map.cell_size/2
		tile_indicator.global_position = global_position_of_tile
		selected.visible = true
	if event.is_action_pressed("cancel"):
		tile_indicator.visible = false
		selected.visible = false
