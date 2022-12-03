extends Timer

var pt = preload("res://Padthai.tscn")
export var ptCount=0
var curWave = 0
var ismatch = 1

func _ready():
	curWave = WaveTracker.waveNum
	ismatch=1


func _process(delta):
	if(WaveTracker.waveNum != curWave):
		ismatch = 0
		curWave = WaveTracker.waveNum
		

func _on_Padthai_Timer_timeout():
	if(ptCount < 3 and ismatch == 1 and curWave != 0):
		var pt1 = pt.instance()
		pt1.position = Vector2(rand_range(-200,750), 160)
		add_child(pt1)
		ptCount +=1
