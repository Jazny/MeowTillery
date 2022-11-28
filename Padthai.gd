extends KinematicBody2D

export var damage = 0

var motion = Vector2()

#const GRAVITY = 50

func _physics_process(delta):
	motion.y += 10
	move_and_slide(motion)

