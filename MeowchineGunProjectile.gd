extends KinematicBody2D

var movement = Vector2()
const SPEED = 1500
export var damage = 10
func _physics_process(delta):
	var collision = move_and_collide(movement * SPEED * delta)
	if collision:
		if collision.collider.name == "Player":
			collision.collider._die()
		if collision.collider.name != "Player":
			queue_free()
		queue_free()
