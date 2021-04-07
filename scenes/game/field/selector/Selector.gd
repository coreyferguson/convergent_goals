extends MarginContainer

onready var tile_indicator = $tile_indicator

onready var selector = $selector
onready var detailed_information_vbox = $selector/scroll/margin/vbox

func _unhandled_input(event):
	if event.is_action_pressed("select_point"):
		_hide_selection()
		var global_position = get_global_mouse_position()
		var v = field_service.tile_map.world_to_map(global_position)
		tile_indicator.visible = true
		var global_position_of_tile = field_service.tile_map.map_to_world(v) + field_service.tile_map.cell_size/2
		tile_indicator.global_position = global_position_of_tile
		if field_service.constructions_map.has(v):
			if field_service.constructions_map[v].has_method('get_selector_ui'):
				var selector_ui = field_service.constructions_map[v].get_selector_ui()
				selector_ui.visible = true
				detailed_information_vbox.add_child(selector_ui)
				selector.visible = true
	if event.is_action_pressed("cancel"):
		_hide_selection()

func _hide_selection():
	tile_indicator.visible = false
	selector.visible = false
	var detailed_information_vbox_children = detailed_information_vbox.get_children()
	for child in detailed_information_vbox_children: child.queue_free()
	
