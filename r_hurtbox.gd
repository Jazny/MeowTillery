extends Area2D

const whiten_duration = 0.15
export (ShaderMaterial) var whiten_material
onready var collision_shape = $CollisionShape2D

export var damage = 0

var is_invincible = false

func start_invincibility(invincibility_duration):
	is_invincible = true
	collision_shape.set_deferred("disabled", true)
	yield(get_tree().create_timer(invincibility_duration),"timeout")
	collision_shape.set_deferred("disabled", false)
	is_invincible = false
