extends Node

signal health_updated(health)
signal killed()

export (float) var max_health = 800
onready var health = max_health setget _set_health

func _set_health(value):
	var prev_health = health
	health = clamp(value,0,max_health)
	if health != prev_health:
		emit_signal("health_updated",health)
		if health <= 0:
			emit_signal("killed")
