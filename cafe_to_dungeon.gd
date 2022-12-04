extends Node2D
export var damage = 0

onready var doors = get_node("/root/Doors")

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			doors.cafe_to_dungeon = true
			doors.entrance = false
			get_tree().change_scene("res://cat_dungeon.tscn")
