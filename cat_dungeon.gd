extends Node2D

onready var catstats = get_node("/root/CatsGlobal")

func _ready():
	if (catstats.grey_cat_alive == false):
		get_node("caged_grey_cat").queue_free()
