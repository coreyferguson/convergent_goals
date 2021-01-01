extends TileMap


func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_released("select_point"):
		var v = world_to_map(get_global_mouse_position())
		print("v: " + String(v))
		var i = get_cellv(v)
		print("i: " + String(i))
		
	# if event is InputEventMouseButton && !event.pressed && !event.button_index:
	# 		print('click released')
