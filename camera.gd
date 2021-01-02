extends Camera2D

export(Vector2) var ZOOM_UNIT = Vector2(0.4, 0.4)
var ZOOM_MIN = ZOOM_UNIT.x # smallest unit above 0
var ZOOM_MAX = 3

const UP = Vector2(0, -25)
const DOWN = Vector2(0, 25)
const RIGHT = Vector2(25, 0)
const LEFT = Vector2(-25, 0)

func _process(delta):
	# zoom
	if Input.is_action_just_released("field_zoom_in"): zoom -= ZOOM_UNIT
	if Input.is_action_just_released("field_zoom_out"): zoom += ZOOM_UNIT
	zoom.x = clamp(zoom.x, ZOOM_MIN, ZOOM_MAX)
	zoom.y = clamp(zoom.y, ZOOM_MIN, ZOOM_MAX)
	
	# position
	var v = Vector2(0,0)
	if Input.is_action_pressed("field_move_camera_left"): v += LEFT * zoom
	if Input.is_action_pressed("field_move_camera_right"): v += RIGHT * zoom
	if Input.is_action_pressed("field_move_camera_up"): v += UP * zoom
	if Input.is_action_pressed("field_move_camera_down"): v += DOWN * zoom
	position += v

func _unhandled_input(event):
	if event.is_action_pressed("camera_reset"):
		position = Vector2(0, 0)
