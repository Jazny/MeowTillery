extends Control

onready var health_bar = $Health

func _ready():
	PlayerStat.connect("health_updated", self, "_health_update")
	_health_update(PlayerStat.health)
	


func _health_update(health):
	health_bar.value = health

func _max_health_update(max_health):
	health_bar.max_value = max_health
