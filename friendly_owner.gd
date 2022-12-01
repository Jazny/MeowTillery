extends Node2D

onready var owner_anim = get_node("owner_animation")
onready var diolog_anim = get_node("diolog")
var can_speak = false

func _ready():
	owner_anim.play("idle")
	diolog_anim.play("speak_to")


func _process(delta):
	if (can_speak == true):
		if (Input.is_action_just_pressed("ui_accept")):
			diolog_anim.hide()


func _on_owner_Area2D_body_entered(body):
	if (body.name == "Squango"):
		owner_anim.play("speaking")
		diolog_anim.play("guide")
		can_speak = true


func _on_owner_Area2D_body_exited(body):
	if (body.name == "Squango"):
		owner_anim.play("idle")
		diolog_anim.show()
		diolog_anim.play("speak_to")
		can_speak = false
