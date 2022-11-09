extends KinematicBody2D

const MOVE_SPEED = 500
const ACC = 80
const JUMP_FORCE = 1000
const WALL_JUMP_FORCE = 600
const GRAVITY = 50
const TERMINAL_VELOCITY = 1000
const WALL_SLIDE_SPEED = 40
const DASH_FORCE = 2500

onready var sprite = $Sprite
var yVelocity = 0
var xVelocity = 0
var lookingRight = true

const invincibility_duration = 1.5
onready var hurtbox = $Hurtbox
onready var blinker = $Blinker
var stats = PlayerStat

var stateJ = "idle"
var stateR = "idle"

func _ready():
	stats.connect("killed", self, "_die")

func _physics_process(delta):
	
	get_tree().call_group("need_player", "set_player", self)
	var onFloor = is_on_floor()
	var onWall = is_on_wall()
	var onCeiling = is_on_ceiling()
	
	if(onFloor and stateR != "dead"):
		stateJ = "idle"
	if(onCeiling):
		yVelocity = 0
	if(onWall):
		xVelocity = 0
		
	if(onWall and Input.is_action_pressed("mv_wall_slide")  and stateR != "dead" ):
		if(lookingRight):
			xVelocity = 5
		else:
			xVelocity = -5
			
	if(Input.is_action_pressed("mv_right") and stateR != "dead"):
		xVelocity = min(xVelocity + ACC, MOVE_SPEED)
		stateR = "running"
	if(Input.is_action_pressed("mv_left")  and stateR != "dead"):
		xVelocity = max(xVelocity - ACC, -MOVE_SPEED)
		stateR = "running"
	if(onFloor and Input.is_action_just_pressed("mv_jump") and !onCeiling  and stateR != "dead"):
		stateJ = "jump1"
		yVelocity = -JUMP_FORCE
	if(stateJ == "jump1" and Input.is_action_just_pressed("mv_jump") and !onFloor and !onCeiling ):
		stateJ = "jump2"
		yVelocity = -JUMP_FORCE
	if(onWall and (stateJ == "jump1" or stateJ == "jump2") and Input.is_action_pressed("mv_wall_slide")):
		yVelocity = WALL_SLIDE_SPEED
		stateJ = "jump2"
	if(onWall and Input.is_action_just_pressed("mv_jump") and Input.is_action_pressed("mv_wall_slide") ):
		wallJump()
		
	move_and_slide(Vector2(xVelocity, yVelocity), Vector2(0, -1))
	if(onFloor):
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
	if(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
		sprite.play("Run")
	elif(Input.is_action_just_pressed("mv_jump")):
		sprite.set_animation("Jump")
		sprite.set_playing(1)
	else:
		sprite.play("Idle")
		
func wallJump():
	yVelocity = -JUMP_FORCE / 2
	if(lookingRight):
		xVelocity = -WALL_JUMP_FORCE
		stateJ = "jump2"
	else:
		xVelocity = WALL_JUMP_FORCE
		stateJ = "jump2"
		
func _die():
	stateJ = "dead"
	stateR = "dead"
	$Particles2D.emitting = true 
	$deathSFX.play(.1)
	$Sprite.play("Death")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Main_Menu.tscn")
	
func _on_Hurtbox_area_entered(area):
	if area.damage != 0:
		if !hurtbox.is_invincible:
			blinker.start_blinking(self, invincibility_duration)
			hurtbox.start_invincibility(invincibility_duration)
			stats.health-=area.damage


func _on_SanityBar_killed():
	_die()


func _input(event):
	if event.is_action_pressed("pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
