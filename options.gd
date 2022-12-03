extends Node2D

onready var music = get_node("/root/Music")

func _ready():
	get_node("HSlider").value = music.volume_db

func _on_HSlider_value_changed(value):
	music.volume_db = value


func _on_Back_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")
