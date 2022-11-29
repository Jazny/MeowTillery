extends Node2D

onready var scenes = get_node("intro scenes")
onready var exposition = get_node("Control/Label")

func _ready():
	scenes.play("scene 1")
	scenes.centered = true
	exposition.autowrap = true
	exposition.set_align(Label.ALIGN_CENTER)
	exposition.text = "Squango has always been a curious person."

## cut scene interaction / switching:
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		if (scenes.animation == "scene 1" || scenes.animation == "scene 1 loop"):
			scenes.play("scene 2")
			exposition.text = "At the age of 2, Squango bio-engineered his mother's pet cat into a (harmless) detonation device."
		elif (scenes.animation == "scene 2"):
			scenes.play("scene 3")
			exposition.text = "Squango was proud of the (harmless) destructive weapon."
		elif (scenes.animation == "scene 3"):
			scenes.play("scene 4")
			exposition.text = "However, this kind of behavior always seemed to land Squango in trouble."
		elif (scenes.animation == "scene 4"):
			scenes.play("scene 5")
			exposition.text = "Until one glorious day when the perfect opportunity found its way to Squango."
		elif (scenes.animation == "scene 5"):
			scenes.play("scene 6")
			exposition.text = ""
		elif (scenes.animation == "scene 6"):
			get_tree().change_scene("res://background_testing.tscn")

func _on_intro_scenes_animation_finished():
	if (scenes.animation == "scene 1"):
		scenes.play("scene 1 loop")
		
