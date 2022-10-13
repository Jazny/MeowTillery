extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var punch: AudioStream = preload("res://[YT2mp3.info] - Punch Sound Effect - Gaming SFX (320kbps).mp3")

# Called when the node enters the scene tree for the first time.
func _ready():
	if (Input.is_action_pressed("mv_attack")):
		self.set_stream(punch)
		self.set_volume_db(20)
		play()
		 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
