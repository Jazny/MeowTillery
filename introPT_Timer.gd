extends Timer

var pt = preload("res://Padthai.tscn")
export var ptCount=0

func _read():
	wait_time = 5.0
	start(wait_time)


func _on_introPT_Timer_timeout():
	var pt1 = pt.instance()
	pt1.position = Vector2(rand_range(-500,1000), 470)
	add_child(pt1)
	ptCount +=1
	start(wait_time)
