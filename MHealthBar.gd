extends Control

onready var health_bar = $Health
#onready var Rstats = 

#func _ready():
#	Rstats.connect("health_updated", self, "_health_update")
#	_health_update(Rstats.health)
	


func _max_health_update(max_health):
	health_bar.max_value = max_health


func _on_Minion_Stats_health_updated(health):
	health_bar.value = health
