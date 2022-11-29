extends Popup

func _ready():
	pass 

## popup show:
func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			popup()
			if get_node("../Control/HungerBar").value < 50:
				get_node("Button").visible = false
				get_node("Button").disabled = true
			else:
				get_node("Button").visible = true
				get_node("Button").disabled = false


## popup hide:
func _on_Area2D_body_exited(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			hide()


func _on_Button_pressed():
	hide()


func _on_Button2_pressed():
	hide()


func _on_Timer_timeout():
	hide()
