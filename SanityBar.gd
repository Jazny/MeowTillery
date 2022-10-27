extends Control

onready var sanity_bar = $Sanity2
signal killed()


func _on_Timer_timeout():
	if $Sanity2.value == 0:
		emit_signal("killed")
	$Sanity2.value-=1
