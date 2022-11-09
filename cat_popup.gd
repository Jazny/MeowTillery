extends Popup

func _ready():
	pass

## popup menu show:
func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if body.name == "Squango":
			popup()

## popup menu hide:
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
