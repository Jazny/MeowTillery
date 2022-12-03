extends Node2D

onready var guide = get_node("guide")

func _ready():
	guide.text = ""


func _on_Area2D_body_entered(body):
	if body.name == "Squango":
		guide.text = "press B to access The Black Cat Market"


func _on_Area2D_body_exited(body):
	if body.name == "Squango":
		guide.text = ""
