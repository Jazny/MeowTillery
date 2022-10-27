extends Sprite

const RANGE = 500
const FIRERATE = 1.0
const TURNING_SPEED = 0.1

var player = null
var projectile = preload("res://TurretProjectile.tscn")
var fireTime = 0.0

func _physics_process(delta):
	if player == null:
		return
	
	fireTime += delta
	if(fireTime > FIRERATE):
		fireTime = 0.0
		shoot()

func shoot():
	if(global_position.distance_to(player.global_position) > RANGE):
		return
	var projInstance = projectile.instance()
	get_tree().get_root().add_child(projInstance)
	projInstance.global_position = global_position
	var dirToPlayer = (player.global_position - global_position).normalized()
	projInstance.movement = dirToPlayer

func set_player(p):
	player = p
