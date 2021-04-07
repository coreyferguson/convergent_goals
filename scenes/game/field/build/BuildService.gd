extends Node

export (Dictionary) var meta = {
	"constructor": {
		"scene": preload("res://scenes/game/field/build/constructor/Constructor.tscn"),
		"fog_radius": 2,
		"reveal_radius": 1,
		"productions": {
			"iron": {
				"capacity": 100,
				"costs": [],
				"quantity": 0,
			},
			"construction_bot": {
				"capacity": 10,
				"costs": [
					{ "name": "iron", "quantity": -10 }
				],
				"quantity": 1,
			},
			"electricity": {
				"capacity": 100,
				"costs": [],
				"quantity": 10,
			},
			 
		}
	}
}

func _ready():
	pass
