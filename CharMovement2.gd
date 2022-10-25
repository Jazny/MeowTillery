extends KinematicBody2D

const MOVE_SPEED = 500
const ACC = 80
const JUMP_FORCE = 1000
const GRAVITY = 50
const TERMINAL_VELOCITY = 1000

onready var sprite = $Sprite
var yVelocity = 0
var xVelocity = 0
var lookingRight = true

var stateJ = "idle"
var stateR = "idle"

func _physics_process(delta):
	var onFloor = is_on_floor()
	var onWall = is_on_wall()
	
	if(Input.is_action_pressed("mv_right")):
		stateR = "running"
		xVelocity = min(xVelocity + ACC, MOVE_SPEED)
	if(Input.is_action_pressed("mv_left")):
		stateR = "running"
		xVelocity = max(xVelocity - ACC, -MOVE_SPEED)
	if(onFloor and Input.is_action_just_pressed("mv_jump")):
		stateJ = "jump1"
		yVelocity = -JUMP_FORCE
	if(stateJ == "jump1" and Input.is_action_just_pressed("mv_jump") and !onFloor):
		stateJ = "jump2"
		yVelocity = -JUMP_FORCE
	
	move_and_slide(Vector2(xVelocity, yVelocity), Vector2(0, -1))
	xVelocity = lerp(xVelocity,0,0.15)
	
	if(lookingRight and xVelocity < 0):
		flip()
	if(!lookingRight and xVelocity > 0):
		flip()
	
	yVelocity += GRAVITY
	if(yVelocity > TERMINAL_VELOCITY):
		yVelocity = TERMINAL_VELOCITY
	if(onFloor and yVelocity >= 5):
		yVelocity = 5
		
	animate()
		
func flip():
	lookingRight = !lookingRight
	sprite.flip_h = !sprite.flip_h
	
func animate():
	if(sprite.get_animation() == "Jump"):
		return
	if(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
		sprite.play("Run")
	elif(Input.is_action_just_pressed("mv_jump")):
		sprite.set_animation("Jump")
		sprite.set_playing(1)
	else:
		sprite.play("Idle")
