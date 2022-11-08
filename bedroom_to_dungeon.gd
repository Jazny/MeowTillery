extends Node2D
var damage = 0

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			get_tree().change_scene("res://cat_dungeon.tscn")
