extends Area2D

export var damage = 0
var active = false

func _ready():
	$"Control/DialogBox/RichTextLabel".visible = false
	$"Control/DialogBox/TextureRect".visible = false
	$"Control/DialogBox/Next-indicator".visible = false
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")

func _process(delta):
	if(Input.is_action_just_pressed("ui_accept") and active == true):
		$"Control/DialogBox/RichTextLabel".visible = true
		$"Control/DialogBox/TextureRect".visible = true
		$"ExclamationMark".visible = false
		

func _on_NPC_body_entered(body):
	if body.name == "Squango":
		active = true
		$"ExclamationMark".visible = active

func _on_NPC_body_exited(body):
	$"Control/DialogBox/RichTextLabel".visible = false
	$"Control/DialogBox/TextureRect".visible = false
	$"Control/DialogBox/Next-indicator".visible = false
	if body.name == "Squango":
		active = false
		$"ExclamationMark".visible = active
