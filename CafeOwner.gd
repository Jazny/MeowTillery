extends KinematicBody2D

const MOVE_SPEED = 150
const ACC = 80
const JUMP_FORCE = 1000
const GRAVITY = 50
const TERMINAL_VELOCITY = 1000
const RANGE = 100

onready var sprite = $AnimatedSprite
var projectile = preload("res://CafeOwnerProjectile.tscn")
var direction = Vector2(0,0)
var lookingRight = true
var player = null
var yVelocity = 0
var xVelocity = 0
var inRange = false
var hasAttacked = 0

func _physics_process(delta):
	if(player == null):
		return
		
	if (inRange == true):
		xVelocity = 0
		if(hasAttacked == 0):
			hasAttacked = 1
			_attack()
		elif(hasAttacked == 1):
			yield(get_tree().create_timer(0.7), "timeout")
			hasAttacked = 0
			
			
	if(global_position.distance_to(player.global_position) > RANGE):
		inRange = false
		
	if (inRange == false):
		_move()
	_animate()
	
func _attack():
	var projInstance = projectile.instance()
	get_tree().get_root().add_child(projInstance)
	var dirToPlayer = (player.global_position - global_position).normalized()
	if(dirToPlayer.x > 0):
		projInstance.global_position.x = global_position.x + 25
		projInstance.global_position.y = global_position.y - 5
	if(dirToPlayer.x < 0):
		projInstance.global_position.x = global_position.x - 25
		projInstance.global_position.y = global_position.y - 5
	projInstance.movement = dirToPlayer
	return
	
func _move():
	if(global_position.distance_to(player.global_position) <= RANGE):
		inRange = true
		
	direction = position.direction_to(player.position)
	
	if(lookingRight and xVelocity <= 0):
		flip()
	if(!lookingRight and xVelocity >= 0):
		flip()
	
	if(direction.x >= 0):
		xVelocity = min(xVelocity + ACC, MOVE_SPEED)
	if(direction.x <= 0):
		xVelocity = max(xVelocity - ACC, -MOVE_SPEED)
		
	move_and_slide(Vector2(xVelocity, yVelocity), Vector2(0, -1))
	xVelocity = lerp(xVelocity,0,0.15)
		
	yVelocity += GRAVITY
	if(yVelocity > TERMINAL_VELOCITY):
		yVelocity = TERMINAL_VELOCITY

func _animate():
	if(xVelocity > 0):
		sprite.play("Walk")
	elif(xVelocity < 0):
		sprite.play("Walk")
	elif(global_position.distance_to(player.global_position) <= RANGE):
		sprite.play("Attack")
	else:
		sprite.play("Idle")
		
func _die():
	queue_free()
	
func flip():
	lookingRight = !lookingRight
	sprite.flip_h = !sprite.flip_h
	
func set_player(p):
	player = p	
		
