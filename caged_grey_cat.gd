extends Node2D
const Catana = preload("res://Inventory/ItemDropCatana.tscn")


func _ready():
	get_node("grey_cat_chilling").play("default")
	

func _on_Button_pressed():
	get_node("grey_cat_chilling").hide()
	get_node("Cage").hide()
	get_node("AnimationPlayer").play("Weapon Unlocked")
	var catana = Catana.instance()
	get_parent().add_child(catana)
	WaveTracker.waveNum = 1
	yield(get_tree().create_timer(3), "timeout")
	queue_free()


func _on_Button2_pressed():
	get_node("grey_cat_chilling").play("eating")
	yield(get_tree().create_timer(2), "timeout")
	get_node("grey_cat_chilling").play("default")


func _on_Timer_timeout():
	get_node("grey_cat_chilling").play("death")
	yield(get_tree().create_timer(3), "timeout")
	queue_free()
