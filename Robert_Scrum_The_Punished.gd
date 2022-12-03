extends KinematicBody2D

const ACC = 50
const GRAVITY = 20
const SPEED = 100
var velocity = Vector2(0,0)
var smartDirection = Vector2(0,0)
var is_moving_right = false
var attacking = false
var isInRange = false
var attackCooldown = false
var burstCooldown = false
var dashCooldown = false
var player = null
var flipRequired = false
var projectile = preload("res://TurretProjectile.tscn")
var state = "walking"
var numShotsFired = 0
var framecounter = 0
var dashDirection = 0
var dashDuration = 0

var RANGE = 1000

const invincibility_duration = 0.5
onready var R2stats = $Robert_Scrum_The_Punished_Stats
onready var hurtbox = $RHurtbox
onready var blinker = $Blinker

func _fire():
	if(global_position.distance_to(player.global_position) > RANGE):
		isInRange = false
		return
	var projInstance = projectile.instance()
	get_tree().get_root().add_child(projInstance)
	var centerOfPlayer = (player.global_position)
	#shoots towards center of player instead of feet
	centerOfPlayer.y -= 40
	var dirToPlayer = (centerOfPlayer - global_position).normalized()
	if(dirToPlayer.x > 0):
		projInstance.global_position.x = global_position.x + 100
		projInstance.global_position.y = global_position.y + 30
	if(dirToPlayer.x < 0):
		projInstance.global_position.x = global_position.x - 100
		projInstance.global_position.y = global_position.y + 30
	projInstance.movement = dirToPlayer

func _dash():
	var dirToPlayer = (player.global_position - global_position).normalized()
	
	if (dashDirection == 0):
		dashDirection = velocity.x
		
	if (dashDirection > 0):
		velocity.x = SPEED * 6
	else:
		velocity.x = SPEED * -6
		
	velocity = move_and_slide(velocity, Vector2.UP)

func _ready():
	isInRange = false
	R2stats.connect("killed", self, "_die")
	
func set_player(p):
	player = p
	
func _process(_delta):
	framecounter += 1
	
	if (state == "dying"):
		$AnimatedSprite.play("death")
		
	else:
		if (state == "walking"):
			move_character()
			
		if (state == "dashing" && dashDuration):
			_dash()
	
		if (!dashCooldown && framecounter > 300 && state != "shooting"):
			_setDashCooldown()
			_setDashDuration()
			
		elif (!burstCooldown && player != null && state != "dashing"):
			state = "shooting"
			if (!attackCooldown):
				_fire()
				_setCooldown()
				numShotsFired += 1
		
			if (numShotsFired >= 3):
				_setBurstCooldown()
				numShotsFired = 0
				state = "walking"

func _setDashDuration():
	dashDuration = true
	yield(get_tree().create_timer(3), "timeout")
	dashDuration = false
	state = "walking"
	
func _setCooldown():
	attackCooldown = true
	yield(get_tree().create_timer(0.5), "timeout")
	attackCooldown = false

func _setBurstCooldown():
	burstCooldown = true
	yield(get_tree().create_timer(3), "timeout")
	burstCooldown = false
	
func _setDashCooldown():
	state = "dashing"
	dashCooldown = true
	yield(get_tree().create_timer(5), "timeout")
	dashCooldown = false
	dashDirection = 0
	state = "walking"

func move_character():
	$AnimatedSprite.play("default")
	
	if (player == null) :
		velocity.x = SPEED
		if (!is_moving_right):
			flipRequired = true
	  
	else:
		smartDirection = position.direction_to(player.position)
	
		if (smartDirection.x >= 0):
			velocity.x = SPEED
			if (!is_moving_right):
				flipRequired = true
			
			is_moving_right = true
			

		else:
			velocity.x = -SPEED
			if (is_moving_right):
				flipRequired = true
				#$HealthBar/Health.FILL_RIGHT_TO_LEFT = true

			is_moving_right = false
		
	if (flipRequired):
		scale.x = -scale.x
		flipRequired = false
		
	velocity.y += GRAVITY
	
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _die():
	state = "dying"
	$Instakill.monitorable = false
	$Instakill.set_deferred("monitorable", false)
	yield(get_tree().create_timer(6), "timeout")
	WaveTracker.enemiesRemaining -= 1
	queue_free()

func _on_RHurtbox_area_entered(area):
	if (area.name == "Hurtbox"):
		if area.damage != 0 and R2stats.health > 0:
			if !hurtbox.is_invincible:
				blinker.start_blinking(self, invincibility_duration)
				hurtbox.start_invincibility(invincibility_duration)
				R2stats.health-=area.damage
