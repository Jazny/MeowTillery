extends Control

var dialog = [
	'Hello there, this is the test dialogue.',
	'If this is an alright implementation, then that would be great.',
	'I hope, PETA and the Ayatollah Cathmeini do not see this.',
	'The Fitness Gram Pacer Test is a multi-stage aerobic capacity test',
	'that progressively gets more difficult as it continues.'
]

var dialog_index = 0
var finished = false

func _ready(): 
	load_dialog()

func _process(delta):
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
		queue_free()
	dialog_index += 1
	
func _on_Tween_tween_completed(object, key):
	finished = true
