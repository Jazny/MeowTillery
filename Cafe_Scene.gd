extends Node2D

onready var doors = get_node("/root/Doors")
onready var squango = get_node("Squango")

func _ready():
	if doors.entrance == true:
		squango.position = Vector2(94, 559)
	else:
		squango.position = Vector2(944, 559)

