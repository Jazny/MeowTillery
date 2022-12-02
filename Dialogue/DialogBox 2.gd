extends Control

var dialog = [
	'Hello there, this is the test dialogue.',
	'If this is an alright implementation, then that would be great.',
	'Run a cat cafe, bombard PITA with cat themed artillery.',
	'Such as Cat-apults, Meowchine Guns, and even Ballsitic Meowsiles!',
	'Even get up close and personal with a Catana!'
]

var dialog_index = -1
var finished = false

func _ready(): 
	load_dialog()

func _process(delta):
	if ($"RichTextLabel".visible == true):
		$"Next-indicator".visible = finished
	
	if(Input.is_action_just_pressed("ui_accept")):
		load_dialog()

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
	dialog_index += 1
	
func _on_Tween_tween_completed(object, key):
	finished = true
