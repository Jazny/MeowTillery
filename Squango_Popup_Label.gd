extends Label

onready var popup = get_node("../../Squango_Popup").is_showing

func _process(delta):
	if (popup == true):
		$Tween.interpolate_property(
			self, "percent_visible", 0.0, 1.0, 3.0, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
