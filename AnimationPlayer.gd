extends AnimationPlayer
onready var animation = $AnimationPlayer

func _process(delta):
	animation.play("TitleScreen")
