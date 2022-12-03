extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Start_pressed():
	get_tree().change_scene("res://Intro_quip.tscn")
	PlayerStat._set_health(100)
	PlayerStat._set_sanity(100)
	

func _on_Quit_pressed():
	get_tree().quit()


func _on_Credits_pressed():
	get_tree().change_scene("res://Credits.tscn")


func _on_Options_pressed():
	get_tree().change_scene("res://Options.tscn")
