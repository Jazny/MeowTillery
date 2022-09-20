extends KinematicBody2D

var velocity = Vector2(0,0)

func _physics_process(delta):
	if Input.is_action_pressed("moveRight"):
		velocity.x = 80
	if Input.is_action_pressed("moveLeft"):
		velocity.x = -80
	
	move_and_slide(velocity)
