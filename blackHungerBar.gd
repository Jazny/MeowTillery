extends TextureProgress

onready var catstats = get_node("/root/CatsGlobal")
var inzone = false

func _ready():
	value = catstats.black_cat_hunger
	tint_progress = Color(0.26, 0.77, 0.19, 1)
	get_node("Timer").wait_time = catstats.black_cat_time_left
	get_node("Timer").start(get_node("Timer").wait_time)

func _process(delta):
	value = get_node("Timer").time_left
	catstats.black_cat_time_left = get_node("Timer").time_left
	catstats.black_cat_hunger = value
	if (value > 70):
		tint_progress = Color(0.26, 0.77, 0.19, 1)
	elif (value <= 70 && value > 50):
		tint_progress = Color(0.88, 0.85, 0.21, 1)
	elif (value <= 50 && value > 30):
		tint_progress = Color(0.88, 0.65, 0.21, 1)
	elif (value <= 30):
		tint_progress = Color(0.88, 0.29, 0.21, 1)
	
	if Input.is_action_just_pressed("Feed") && inzone == true:
		if (value < 90):
			get_node("Timer").wait_time+=10
			get_node("Timer").start(get_node("Timer").wait_time)


func _on_Timer_timeout():
	hide()

