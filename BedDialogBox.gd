extends Control

var dialog = [
	'Would you like to sleep? Press Enter.',
	'Sleep completed.'
]

var dialog_index = -1
var finished = false

var count = 0

func _ready(): 
	load_dialog()

func _process(delta):
	if ($"RichTextLabel".visible == true):
		$"Next-indicator".visible = finished
	
	if(Input.is_action_just_pressed("ui_accept")):
		load_dialog()
		if count == 1:
			PlayerStat._set_health(100)
		count +=1
		
		

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
