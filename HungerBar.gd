extends TextureProgress

func _ready():
	value = 100
	tint_progress = Color(0.26, 0.77, 0.19, 1)
	get_node("Timer").wait_time = 200
	get_node("Timer").start(get_node("Timer").wait_time)

func _process(delta):
	value = (get_node("Timer").time_left / get_node("Timer").wait_time) * 100
	if (value > 70):
		tint_progress = Color(0.26, 0.77, 0.19, 1)
	elif (value <= 70 && value > 50):
		tint_progress = Color(0.88, 0.85, 0.21, 1)
	elif (value <= 50 && value > 30):
		tint_progress = Color(0.88, 0.65, 0.21, 1)
	elif (value <= 30):
		tint_progress = Color(0.88, 0.29, 0.21, 1)


func _on_Timer_timeout():
	hide()
	
	
func _on_Button_pressed():
	hide()
