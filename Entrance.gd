extends Node2D

func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			get_tree().change_scene("res://Cafe_Scene.tscn")