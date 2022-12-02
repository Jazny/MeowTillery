extends Node2D

onready var objective = get_node("AnimationPlayer")
onready var cam = get_node("Squango").get_node("Camera2D")

func _ready():
	cam.current = false
	cam.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	objective.play("Objective")
	yield(get_tree().create_timer(3), "timeout")
	
