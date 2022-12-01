extends Label

func _ready():
	$Tween.interpolate_property(
		self, "percent_visible", 0.0, 1.0, 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()


func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		$Tween.interpolate_property(
			self, "percent_visible", 0.0, 1.0, 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
