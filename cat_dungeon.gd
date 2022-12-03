extends Node2D

onready var catstats = get_node("/root/CatsGlobal")
onready var doors = get_node("/root/Doors")
onready var squango = get_node("Squango")

func _ready():
	if (catstats.grey_cat_alive == false):
		get_node("caged_grey_cat").queue_free()
	if (catstats.calico_cat_alive == false):
		get_node("caged_calico_cat").queue_free()
	if (catstats.black_cat_alive == false):
		get_node("caged_black_cat").queue_free()
	
	if (doors.cafe_to_dungeon == true):
		squango.position = Vector2(-867.236, 812.912)
	else:
		squango.position = Vector2(288.369, 812.912)
