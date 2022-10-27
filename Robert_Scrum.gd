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

func _ready():
	isInRange = false
	
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
	$AnimatedSprite.play("default")
	smartDirection = position.direction_to(squango.position)
	
	if (smartDirection.x >= 0):
		velocity.x = SPEED
		if (!is_moving_right):
			flipRequired = true
			
		is_moving_right = true
	
	else:
		velocity.x = -SPEED
		if (is_moving_right):
			flipRequired = true
		
		is_moving_right = false
		
	if (flipRequired):
		scale.x = -scale.x
		flipRequired = false
		
	velocity.y += GRAVITY
	
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_PlayerDetector_body_entered(body):
	isInRange = true
	
func _on_PlayerDetector_body_exited(body):
	isInRange = false

func _on_AttackDetector_body_entered(body):
	print("hit successful")

func _on_AttackDetector_body_exited(body):
	pass

func _on_SquangoSeeker_body_entered(body):
	if (body != self):
		squango = body
