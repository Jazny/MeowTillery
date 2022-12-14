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

func _on_Hurtbox_area_entered(area):
	if area.damage != 0 and PlayerStat.health > 0 and PlayerStat.sanity > 0:
		whiten_material.set_shader_param("whiten", true)
		yield(get_tree().create_timer(whiten_duration), "timeout")
		whiten_material.set_shader_param("whiten", false)
