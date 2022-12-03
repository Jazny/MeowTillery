extends Node2D

onready var doors = get_node("/root/Doors")

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			doors.entrance = false
			doors.exit = true
			get_tree().change_scene("res://background_testing.tscn")
