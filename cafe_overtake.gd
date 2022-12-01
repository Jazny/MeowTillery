extends Node2D

onready var objective = get_node("AnimationPlayer")

func _ready():
	objective.play("Objective")
	yield(get_tree().create_timer(3), "timeout")
	
