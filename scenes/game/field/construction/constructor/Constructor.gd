extends Node2D

func _ready():
	reveal()

func reveal():
	field_service.fog(global_position, construction_service.meta.constructor.fog_radius)
	field_service.reveal(global_position, construction_service.meta.constructor.reveal_radius)
