extends RichTextLabel

var waveClearedDisplayed = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	WaveTracker.waveCleared = 0
	if (WaveTracker.waveNum != 0):
		text = ("Wave " + str(WaveTracker.waveNum))
		yield(get_tree().create_timer(4), "timeout")
		text = ""
	else:
		text = ""
	
func _printWaveClear():
	text = "Wave Cleared"
	yield(get_tree().create_timer(4), "timeout")
	text = ""


func _process(delta):
	if (WaveTracker.waveCleared && !waveClearedDisplayed && WaveTracker.waveNum != 0):
		_printWaveClear()
		print("wave cleared: ", WaveTracker.waveCleared)
		print("displayed: ", waveClearedDisplayed)
		print("tracker: ", WaveTracker.waveNum)
		
		waveClearedDisplayed = 1
