extends Node2D
export var damage = 0

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			get_tree().change_scene("res://bedroom_scene.tscn")
