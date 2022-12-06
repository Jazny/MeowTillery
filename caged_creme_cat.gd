extends Node2D

const Catlass = preload("res://Inventory/ItemDropCatlass.tscn")
func _ready():
	get_node("creme_cat_chilling").play("default")
	

func _on_Button_pressed():
	get_node("creme_cat_chilling").hide()
	get_node("Cage").hide()
	get_node("AnimationPlayer").play("Weapon Unlocked")
	var catlass = Catlass.instance()
	add_child(catlass)
	if (WaveTracker.waveNum == 0):
		WaveTracker.waveNum = 1
	yield(get_tree().create_timer(3), "timeout")
	queue_free()


func _on_Button2_pressed():
	get_node("creme_cat_chilling").play("eating")
	yield(get_tree().create_timer(2), "timeout")
	get_node("creme_cat_chilling").play("default")


func _on_Timer_timeout():
	get_node("creme_cat_chilling").play("death")
	yield(get_tree().create_timer(3), "timeout")
	queue_free()
