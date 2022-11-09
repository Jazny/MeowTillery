extends Node2D

var minion = preload("res://minion.tscn")
var jenner = preload("res://Kendall_Jenner.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
#	var minion1 = minion.instance()
#	var minion2 = minion.instance()
#	var minion3 = minion.instance()
	
#	minion1.position = Vector2(500, 300)
#	minion2.position = Vector2(600, 300)
#	minion3.position = Vector2(600, 100)
	
#	add_child(minion1)
#	add_child(minion2)
#	add_child(minion3)

	var jenner1 = jenner.instance()
	jenner1.position = Vector2(600, 100)
	add_child(jenner1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
