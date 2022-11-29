extends Timer

var pt = preload("res://Padthai.tscn")
export var ptCount=0

func _ready():
	pass # Replace with function body.


func _on_Padthai_Timer_timeout():
	if(ptCount < 3):
		var pt1 = pt.instance()
		pt1.position = Vector2(rand_range(-200,750), 160)
		add_child(pt1)
		ptCount +=1
