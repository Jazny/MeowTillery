extends TextureProgress

onready var grey_cat_stats = get_node("/root/CatsGlobal")
var inzone = false

func _ready():
	value = grey_cat_stats.grey_cat_hunger
	tint_progress = Color(0.26, 0.77, 0.19, 1)
	get_node("Timer").wait_time = grey_cat_stats.grey_cat_time_left
	get_node("Timer").start(get_node("Timer").wait_time)

func _process(delta):
	value = get_node("Timer").time_left
	grey_cat_stats.grey_cat_time_left = get_node("Timer").time_left
	grey_cat_stats.grey_cat_hunger = value
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
			get_node("Timer").start(100)


func _on_Timer_timeout():
	hide()

