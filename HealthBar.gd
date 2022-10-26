extends Control

onready var health_bar = $Health

func _health_update(health, amount):
	health_bar.value = health

func _max_health_update(max_health):
	health_bar.max_value = max_health



func _on_Timer_timeout():
	$Health.value-=1
