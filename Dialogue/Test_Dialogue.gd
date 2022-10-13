extends Area2D

var active = false

func _ready():
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")

func _process(delta):
	$"ExclamationMark".visible = active

func _on_NPC_body_entered(body):
	if body.name == "Squango":
		active = true

func _on_NPC_body_exited(body):
	if body.name == "Squango":
		active = false

