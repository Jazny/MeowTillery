extends Node2D

func _ready():
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(5), "timeout")
	get_tree().change_scene("res://Main_Menu.tscn")
