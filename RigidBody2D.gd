extends KinematicBody2D

const ACC = 50
const GRAVITY = 20
const SPEED = 200
var velocity = Vector2(0,0)

func _attack():
	$Sprite.play("Attack")
	$punchSFX.play(.18)
		
func _jump():
	$Sprite.play("Jump")
	velocity.y = -450
	$jumpSFX.play(.5)
	

func _physics_process(delta): 
		
	velocity.y += GRAVITY
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	if(Input.is_action_pressed("mv_right")):
		$Sprite.flip_h = false
		$Sprite.play("Run")
		velocity.x = min(velocity.x + ACC, SPEED)
		
	elif(Input.is_action_pressed("mv_left")):
		$Sprite.flip_h = true
		$Sprite.play("Run")
		velocity.x = max(velocity.x - ACC, -SPEED)
	
	elif(Input.is_action_just_pressed("mv_jump")):
		_jump()
	
	elif(Input.is_action_pressed("mv_attack")):
		_attack()
		
	elif(Input.is_action_pressed("mv_death")):
		$Sprite.play("Death")
		
	else: 
		$Sprite.play("Idle")
	
	move_and_slide(velocity)
	velocity.x = lerp(velocity.x,0,0.15)

