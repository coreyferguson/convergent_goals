extends Node

var SCREEN_RESOLUTION = Vector2(1920, 1080)
onready var tile_map = $'/root/field/tile_map'
onready var constructions_container = $'/root/field/constructions'

var constructions_map = {}

func _ready():
	_reset()

func _reset():
	_generate_map()
	
func _get_cell_n(v):
	v = Vector2(v)
	v.y -= tile_map.cell_size.y
	return tile_map.get_cellv(v)

func _generate_map():
	# Create constructor in the middle of the screen
	var mid_cell = tile_map.world_to_map(field_service.SCREEN_RESOLUTION / 2)
	var ConstructorScene = build_service.meta.constructor.scene
	var constructor_instance = ConstructorScene.instance()
	var constructor_position = tile_map.map_to_world(mid_cell)
	constructor_position += tile_map.cell_size / 2
	constructor_instance.global_position = constructor_position
	constructions_container.add_child(constructor_instance)
	constructions_map[mid_cell] = constructor_instance
	constructor_instance.add_item({ 'name': 'iron', 'quantity': 10 })

func _get_relative_cell(cell_vector, direction):
	var global_position = tile_map.map_to_world(cell_vector) + tile_map.cell_size/2
	global_position += Vector2(direction.x*tile_map.cell_size.x, direction.y*tile_map.cell_size.y)
	return tile_map.world_to_map(global_position)

func _reveal(global_position, radius, tile_index):
	var v = tile_map.world_to_map(global_position)
	tile_map.set_cellv(v, tile_index)
	v = _get_relative_cell(v, Vector2(0, -1))
	for depth in range(1, radius+1):
		for i in range(1, depth+1):
			v = _get_relative_cell(v, Vector2(1, 0.5))
			tile_map.set_cellv(v, tile_index)
		for i in range(1, depth+1):
			v = _get_relative_cell(v, Vector2(0, 1))
			tile_map.set_cellv(v, tile_index)
		for i in range(1, depth+1):
			v = _get_relative_cell(v, Vector2(-1, 0.5))
			tile_map.set_cellv(v, tile_index)
		for i in range(1, depth+1):
			v = _get_relative_cell(v, Vector2(-1, -0.5))
			tile_map.set_cellv(v, tile_index)
		for i in range(1, depth+1):
			v = _get_relative_cell(v, Vector2(0, -1))
			tile_map.set_cellv(v, tile_index)
		for i in range(1, depth+1):
			v = _get_relative_cell(v, Vector2(1, -0.5))
			tile_map.set_cellv(v, tile_index)
		v = _get_relative_cell(v, Vector2(0, -1))

func fog(global_position, radius):
	_reveal(global_position, radius, tile_map.FOG)

func reveal(global_position, radius):
	_reveal(global_position, radius, tile_map.VISIBLE)
