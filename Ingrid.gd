extends KinematicBody2D

const FIRERATE = 0.2
const MOVE_SPEED = 50
const ACC = 80
const JUMP_FORCE = 1000
const GRAVITY = 50
const TERMINAL_VELOCITY = 1000
const RANGE = 600

onready var sprite = $Sprite
var direction = Vector2(0,0)
var lookingRight = true
var player = null
var yVelocity = 0
var xVelocity = 0
var inRange = false
var projectile = preload("res://IngridProjectile.tscn")
var fireTime = 0.0
var burstCounter = 0;

const invincibility_duration = 0.5
onready var Istats = $Ingrid_Stats
onready var hurtbox = $RHurtbox
onready var blinker = $Blinker


func _physics_process(delta):
	if(player == null):
		return
		
	if (inRange == true):
		xVelocity = 0
		fireTime += delta
		if(burstCounter >= 5):
			yield(get_tree().create_timer(0.7), "timeout")
			burstCounter = 0
			fireTime = 0.0
		elif(fireTime > FIRERATE):
			fireTime = 0.0
			burstCounter += 1
			_fire()
			
	if (inRange == false):
		_move()
	
	
func _fire():
	if(global_position.distance_to(player.global_position) > RANGE):
		inRange = false
		return
	var projInstance = projectile.instance()
	get_tree().get_root().add_child(projInstance)
	var dirToPlayer = (player.global_position - global_position).normalized()
	if(dirToPlayer.x > 0):
		projInstance.global_position.x = global_position.x + 100
		projInstance.global_position.y = global_position.y + 50
	if(dirToPlayer.x < 0):
		projInstance.global_position.x = global_position.x - 100
		projInstance.global_position.y = global_position.y + 50
	projInstance.movement = dirToPlayer
	
	
func _move():
	if(global_position.distance_to(player.global_position) <= RANGE):
		inRange = true
		
	direction = position.direction_to(player.position)
	
	if(direction.x >= 0):
		xVelocity = min(xVelocity + ACC, MOVE_SPEED)
	if(direction.x <= 0):
		xVelocity = max(xVelocity - ACC, -MOVE_SPEED)
		
	move_and_slide(Vector2(xVelocity, yVelocity), Vector2(0, -1))
	xVelocity = lerp(xVelocity,0,0.15)
	
	if(lookingRight and xVelocity <= 0):
		flip()
	if(!lookingRight and xVelocity >= 0):
		flip()
		
	yVelocity += GRAVITY
	if(yVelocity > TERMINAL_VELOCITY):
		yVelocity = TERMINAL_VELOCITY	


func _die():
	queue_free()
	

func flip():
	lookingRight = !lookingRight
	sprite.flip_h = !sprite.flip_h
	if($BHealthBar/Health.fill_mode == 1):
			$BHealthBar/Health.fill_mode = 0
	else:
			$BHealthBar/Health.fill_mode = 1
	
func set_player(p):
	player = p




func _on_RHurtbox_area_entered(area):
	if area.damage != 0 and Istats.health > 0:
		if !hurtbox.is_invincible:
			blinker.start_blinking(self, invincibility_duration)
			hurtbox.start_invincibility(invincibility_duration)
			Istats.health-=area.damage
