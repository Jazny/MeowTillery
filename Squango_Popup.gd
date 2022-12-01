extends Popup

onready var speech = get_node("Label")
var enter = 0
var is_showing = false

func _ready():
	speech.autowrap = true


func _physics_process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		if (enter % 2 == 1):
			popup()
			is_showing = true
			go_through_dialogue()
		else:
			hide()
			is_showing = false
		enter = enter + 1


func go_through_dialogue():
	if (enter == 1):
		speech.text = "No."
	elif (enter == 3):
		speech.text = "I'm here to work. With the cats."
	elif (enter == 5):
		speech.text = "..."
	elif (enter == 7):
		speech.text = "..."
	elif (enter == 9):
		speech.text = "..."
	elif (enter == 11):
		speech.text = "Okay. I am instigating violence now."

