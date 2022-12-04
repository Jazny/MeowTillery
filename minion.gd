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
var squango = null
var flipRequired = false

const invincibility_duration = 0.5
onready var Mstats = $Minion_Stats
onready var hurtbox = $RHurtbox
onready var blinker = $Blinker

func _ready():
	isInRange = false
	Mstats.connect("killed", self, "_die")
	
func _process(_delta):
	if (isInRange):
		_attack()
		
	else:
		if (!attacking):
			move_character()

func _attack():
	velocity.x = 0
	$AnimatedSprite.play("shooting")
	
	if (!attackCooldown):
		_setCooldown()
		_hit()
		yield(get_tree().create_timer(1.0), "timeout")
		_hitEnd()
	
func _setCooldown():
	attackCooldown = true
	yield(get_tree().create_timer(1.0), "timeout")
	attackCooldown = false
	
	
func _hit():
	attacking = true
	$AttackDetector.monitoring = true
	
func _hitEnd():
	attacking = false
	$AttackDetector.monitoring = false

func move_character():
	$AnimatedSprite.play("Walking")
	
	if (is_moving_right):
		velocity.x = SPEED
		$HealthBar/Health.fill_mode = 1
		
	else:
		velocity.x = -SPEED
		$HealthBar/Health.fill_mode = 0
	
	velocity.y += GRAVITY
	
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _die():
	WaveTracker.enemiesRemaining -= 1
	print("enemies remaining: ", WaveTracker.enemiesRemaining)
	queue_free()

func _on_AttackDetector_body_entered(body):
	if (body.name == "Squango"):
		print("hit successful")

	else:
		if (is_moving_right):
			scale.x = -scale.x
			is_moving_right = false
		else:
			is_moving_right = true
			scale.x = -scale.x

func _on_StompDetector_body_entered(body):
	if (body.name == "Squango"):
		print("goomba stomped")
		WaveTracker.enemiesRemaining -= 1
		print("enemies remaining: ", WaveTracker.enemiesRemaining)
		queue_free()


func _on_RHurtbox_area_entered(area):
	if (area.name == "Hurtbox" or area.name == "CatanaHitBox" or area.name == "CatlassHitBox"):
		if area.damage != 0 and Mstats.health > 0:
			if !hurtbox.is_invincible:
				blinker.start_blinking(self, invincibility_duration)
				hurtbox.start_invincibility(invincibility_duration)
				Mstats.health-=area.damage
