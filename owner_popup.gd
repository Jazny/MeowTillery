extends Popup

onready var dio = get_node("../friendly_owner")
onready var speech = get_node("Label")
onready var guide = get_node("guide")
var is_showing = false
var enter = 0

func _ready():
	speech.autowrap = true


func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") && dio.can_speak == true):
		if (enter % 2 == 0):
			popup()
			is_showing = true
			go_through_dialogue()
		else:
			hide()
			is_showing = false
		enter = enter + 1
	
	elif (enter == 12):
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://cafe_overtake_dual.tscn")


func go_through_dialogue():
	if (enter == 0):
		speech.text = "Hello! You look fairly unnerving and ominous. Would you like to visit Cat Cafe for a serene and relaxing experience?"
		guide.text = ">> Enter to continue"
	elif (enter == 2):
		speech.text = "Oh."
	elif (enter == 4):
		speech.text = "Oh, right! Yes! I am looking for somebody friendly and bubbly to help me maintain the cafe and take care of the cats!"
	elif (enter == 6):
		speech.text = "You don't look like you're either of those things, but that's okay! Mainly, I just need to make sure the cats are safe and taken care of."
	elif (enter == 8):
		speech.text = "Lastly, and I'm sure I don't have to specify this, I cannot have anyone performing biomedical engineering on the cats or turning them into weaponized cyborgs haha."
	elif (enter == 10):
		speech.text = "  :-)  "
