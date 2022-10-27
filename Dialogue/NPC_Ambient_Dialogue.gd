extends Area2D

var active = false

func _ready():
	$"QuestionMark".visible = false
	$"Control/DialogBox/RichTextLabel".visible = false
	$"Control/DialogBox/TextureRect".visible = false
	$"Control/DialogBox/Next-indicator".visible = false
	connect("body_entered", self, "_on_NPC_body_entered")
	connect("body_exited", self, "_on_NPC_body_exited")

func _process(delta):
	if(active == true):
		$"Control/DialogBox/RichTextLabel".visible = true
		$"Control/DialogBox/TextureRect".visible = true

func _on_NPC_body_entered(body):
	if body.name == "Squango":
		$"QuestionMark".visible = true
		active = true

func _on_NPC_body_exited(body):
	$"Control/DialogBox/RichTextLabel".visible = false
	$"Control/DialogBox/TextureRect".visible = false
	$"Control/DialogBox/Next-indicator".visible = false
	$"QuestionMark".visible = false
	if body.name == "Squango":
		active = false
