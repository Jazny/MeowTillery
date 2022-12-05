extends KinematicBody2D

const ACC = 50
const GRAVITY = 20
const SPEED = 50
var velocity = Vector2(0,0)
var smartDirection = Vector2(0,0)
var is_moving_right = true
var attacking = false
var isInRange = false
var attackCooldown = false
var squango = null
var flipRequired = false

## consts
const invincibility_duration = 0.5
onready var Cstats = $Charger_Stats
onready var hurtbox = $RHurtbox
onready var blinker = $Blinker
onready var animation = $AnimatedSprite

func _ready():
	isInRange = false
	Cstats.connect("killed", self, "_die")
	#$HealthBar/Health.fill_mode = 0
	
func _process(_delta):
	if (isInRange):
		animation.play("rushing")
		_attack()
		
	else:
		animation.play("walking")
		move_character()

func _attack():
	
	smartDirection = position.direction_to(squango.position)
	
	if (smartDirection.x >= 0):
		velocity.x = SPEED * 6
		if (!is_moving_right):
			flipRequired = true
			
		is_moving_right = true
	
	else:
		velocity.x = -SPEED * 6
		if (is_moving_right):
			flipRequired = true
		
		is_moving_right = false
		
	if (flipRequired):
		scale.x = -scale.x
		flipRequired = false
		if($HealthBar/Health.fill_mode == 1):
			$HealthBar/Health.fill_mode = 0
		else:
			$HealthBar/Health.fill_mode = 1
		
		
	velocity = move_and_slide(velocity, Vector2.UP)

func move_character():
	if (!is_moving_right):
		velocity.x = -SPEED
		$HealthBar/Health.fill_mode = 0
	else:
		velocity.x = SPEED
		$HealthBar/Health.fill_mode = 1
		
	velocity.y += GRAVITY
	
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _die():
	WaveTracker.enemiesRemaining -= 1
	queue_free()
	get_tree().change_scene("res://background_testing.tscn")

func _on_AttackDetector_body_entered(body):
	if (body.name == "Squango"):
		print("hit successful")
	else:
		if (is_moving_right):
			scale.x = -scale.x
			is_moving_right = false
			$HealthBar/Health.fill_mode = 1
		else:
			is_moving_right = true
			scale.x = -scale.x
			$HealthBar/Health.fill_mode = 0

func _on_SquangoSeeker_body_entered(body):
	if (body.name == "Squango"):
		squango = body
		isInRange = true


func _on_SquangoSeeker_body_exited(body):
	if (body.name == "Squango"):
		isInRange = false


func _on_RHurtbox_area_entered(area):
	if (area.name == "Hurtbox"):
		if area.damage != 0 and Cstats.health > 0:
			if !hurtbox.is_invincible:
				blinker.start_blinking(self, invincibility_duration)
				hurtbox.start_invincibility(invincibility_duration)
				Cstats.health-=area.damage
