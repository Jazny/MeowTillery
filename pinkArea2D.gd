extends Area2D
var damage = 0

func _on_Timer_timeout():
	set_monitoring(false)
	set_monitorable(false)
