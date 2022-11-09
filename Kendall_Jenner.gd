extends KinematicBody2D

const ACC = 50
const GRAVITY = 20
const SPEED = 50
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
		
	velocity = move_and_slide(velocity, Vector2.UP)

func move_character():
	if (!is_moving_right):
		velocity.x = -SPEED
	else:
		velocity.x = SPEED
		
	velocity.y += GRAVITY
	
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	velocity = move_and_slide(velocity, Vector2.UP)

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

func _on_SquangoSeeker_body_entered(body):
	if (body.name == "Squango"):
		squango = body
		isInRange = true


func _on_SquangoSeeker_body_exited(body):
	if (body.name == "Squango"):
		isInRange = false
