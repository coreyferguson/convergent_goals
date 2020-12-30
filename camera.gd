extends Camera2D

export(Vector2) var ZOOM_UNIT = Vector2(0.2, 0.2)
var ZOOM_MIN = ZOOM_UNIT.x # smallest unit above 0
var ZOOM_MAX = 3

export(Vector2) var SURFACE_AREA = Vector2(1920, 1080)
var SURFACE_AREA_HALF = SURFACE_AREA / 2

const UP = Vector2(0, -10)
const DOWN = Vector2(0, 10)
const RIGHT = Vector2(10, 0)
const LEFT = Vector2(-10, 0)

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
	
	print('get_camera_position ( ) : ' + String(get_camera_position ( ) ))
	print('get_camera_screen_center ( ): ' + String())
	var center = get_camera_screen_center()
	
	# position corners
	global_position.x = clamp(global_position.x, -SURFACE_AREA_HALF.x, SURFACE_AREA_HALF.x)
	global_position.y = clamp(global_position.y, -SURFACE_AREA_HALF.y, SURFACE_AREA_HALF.y)