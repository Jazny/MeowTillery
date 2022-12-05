extends Node2D

onready var guide = get_node("guide")
onready var Owner = get_node("owner")

func _ready():
	guide.text = "A/D to move. Left Click for attack. Click 'esc' for all control"

func _process(delta):
	if Owner.is_dead == true:
		get_tree().change_scene("res://background_testing.tscn")
