extends KinematicBody2D

const ACC = 50
const GRAVITY = 20
const SPEED = 200
var velocity = Vector2(0,0)
var i = 0;

func _physics_process(delta): 
	
	if(i == 600):
		i = 0
		
	i += 1
	
	velocity.y += GRAVITY
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
		
	if(i <= 100):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
		velocity.x = min(velocity.x + ACC, SPEED)
		
	elif(i > 200 && i <= 300):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
		velocity.x = max(velocity.x - ACC, -SPEED)
		
	elif(i > 300 && i <= 310):
		$AnimatedSprite.play("Jump")
		velocity.y = -450
		
	else: $AnimatedSprite.play("Idle")
	
	move_and_slide(velocity)
	velocity.x = lerp(velocity.x,0,0.15)
