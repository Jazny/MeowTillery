extends KinematicBody2D

const ACC = 40.5
const GRAVITY = 12
const SPEED = 200

var velocity = Vector2(0,0)
	
	
func _physics_process(delta): 
		
	velocity.y += GRAVITY
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	
	if(Input.is_action_pressed("mv_right")):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("running_left")
		velocity.x = min(velocity.x + ACC, SPEED)
		
	elif(Input.is_action_pressed("mv_left")):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("running_left")
		velocity.x = max(velocity.x - ACC, -SPEED)
		
	else: 
		$AnimatedSprite.play("idle_left")
	
	move_and_slide(velocity)
	velocity.x = lerp(velocity.x,0,0.15)

