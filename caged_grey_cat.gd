extends Node2D

func _ready():
	get_node("grey_cat_chilling").play("default")
	

func _on_Button_pressed():
	get_node("grey_cat_chilling").hide()
	get_node("Cage").hide()
	get_node("AnimationPlayer").play("Weapon Unlocked")


func _on_Button2_pressed():
	get_node("grey_cat_chilling").play("eating")
	yield(get_tree().create_timer(2), "timeout")
	get_node("grey_cat_chilling").play("default")


func _on_Timer_timeout():
	get_node("grey_cat_chilling").play("death")
