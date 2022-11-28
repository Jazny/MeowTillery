extends Timer

var pt = preload("res://Padthai.tscn")

func _ready():
	pass # Replace with function body.


func _on_Padthai_Timer_timeout():
	var pt1 = pt.instance()
	pt1.position = Vector2(rand_range(50,750), 160)
	add_child(pt1)
