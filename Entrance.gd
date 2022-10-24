extends Node2D

func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		get_tree().change_scene("res://Cafe_Scene.tscn")
