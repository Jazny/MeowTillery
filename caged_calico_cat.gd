extends Node2D
const Catlass = preload("res://Inventory/ItemDropCatlass.tscn")

onready var catstats = get_node("/root/CatsGlobal")
onready var guide = get_node("guide")
onready var hunger = get_node("Control/HungerBar")
var inzone = false

func _ready():
	get_node("AnimatedSprite").play("default")
	

func _process(delta):
	if Input.is_action_just_pressed("Weaponize"):
		if (inzone == true) && (catstats.calico_cat_num_times_fed > 2):
			get_node("AnimatedSprite").hide()
			get_node("Cage").hide()
			get_node("AnimationPlayer").play("Weapon Unlocked")
			hunger.hide()
			catstats.calico_cat_alive = false
			guide.visible = false
			var catlass = Catlass.instance()
			get_parent().add_child(catlass)
			WaveTracker.waveNum = 1
			yield(get_tree().create_timer(3), "timeout")
		elif (inzone == true):
			guide.text = "You must feed this cat at least three times to weaponize it."
	
	elif Input.is_action_just_pressed("Feed"):
		if (inzone == true) && (get_node("Control/HungerBar").value < 90):
			guide.text = "Eating..."
			yield(get_tree().create_timer(2), "timeout")
			guide.text = ""
			get_node("AnimatedSprite").play("default")
			catstats.calico_cat_num_times_fed+=1
		elif (inzone == true):
			guide.text = "Cannot feed this cat until it is hungry"


func _on_Timer_timeout():
	catstats.calico_cat_alive = false

func _on_Area2D_body_entered(body):
	if body.name == "Squango":
		inzone = true
		get_node("Control/HungerBar").inzone = true
		guide.text = "Press 'F' to feed. Press W to weaponize."

func _on_Area2D_body_exited(body):
	if body.name == "Squango":
		inzone = false
		get_node("Control/HungerBar").inzone = false
		guide.text = ""
