extends Node

signal health_updated(health)
signal sanity_updated(sanity)
signal killed()

export (float) var max_health = 100
onready var health = max_health setget _set_health
#onready var health = 80 setget _set_health

export (float) var max_sanity = 100
onready var sanity = max_sanity setget _set_sanity


func _set_sanity(value):
	var prev_sanity = sanity
	sanity = clamp(value,0,max_sanity)
	if sanity != prev_sanity:
		emit_signal("sanity_updated",sanity)
		if sanity <= 0:
			emit_signal("killed")

func _set_health(value):
	var prev_health = health
	health = clamp(value,0,max_health)
	if health != prev_health:
		emit_signal("health_updated",health)
		if health <= 0:
			emit_signal("killed")
