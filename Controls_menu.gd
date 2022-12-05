extends Node2D

func _ready():
	visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if visible == false:
			visible = true
		else:
			visible = false
			
