extends Control

#onready var sanity_bar = $Sanity
signal killed()


func _on_Timer_timeout():
	if $Sanity.value == 0:
		emit_signal("killed")
	$Sanity.value-=1

