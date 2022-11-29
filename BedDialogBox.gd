extends Control

var dialog = [
	'Would you like to sleep? Press Enter.',
	'You are now sleeping.'
]

var dialog_index = -1
var finished = false

var count = 0
var sleeping = false
var sleepCount = 0
var flipped = false

onready var Squa = get_parent().get_parent().get_parent().get_node("Squango")

func _ready(): 
	load_dialog()

func _process(delta):
	if ($"RichTextLabel".visible == true):
		$"Next-indicator".visible = finished
	
	if(Input.is_action_just_pressed("ui_accept")):
		load_dialog()
		if count == 1:
			sleeping = true
		count +=1
	
	if(sleeping):
		get_parent().get_parent().get_parent().get_node("Squango/Sprite").play("Sleep")
		if(Squa.lookingRight and flipped == false):
			Squa.lookingRight = !Squa.lookingRight
			Squa.position = Vector2(527,340)
			Squa.scale = Vector2(1.6,1.6)
			flipped = true
		if(Input.is_action_just_pressed("mv_left") || Input.is_action_just_pressed("mv_right") || Input.is_action_just_pressed("mv_jump")):
			sleeping = false
			Squa.lookingRight = !Squa.lookingRight
			flipped = false
			Squa.scale = Vector2(3.01495,3.01495)
		if(sleepCount > 50):
			PlayerStat._set_health(PlayerStat.health + 1)
			sleepCount=0
		else:
			sleepCount+=1
	

func load_dialog():
	if(dialog_index < dialog.size()):
		finished = false
		$RichTextLabel.bbcode_text = dialog[dialog_index]
		$RichTextLabel.percent_visible = 0
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()
	else:
		dialog_index = -1
		count =0
	dialog_index += 1
	
func _on_Tween_tween_completed(object, key):
	finished = true
