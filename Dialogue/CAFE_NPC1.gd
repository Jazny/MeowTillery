extends KinematicBody2D


const ACC = 500
const GRAVITY = 20
const SPEED = 20
var velocity = Vector2(0,0)
var rng = RandomNumberGenerator.new()

func _process(delta):
	rng.randomize() 
	var randnum = rng.randi_range(0, 17)
	var randnum2 = rng.randi_range(0, 12)
	var randnum3 = rng.randi_range(0, 38)
	
	velocity.y += GRAVITY
	if(velocity.y > GRAVITY * 20):
		velocity.y = GRAVITY * 20
	if( ((randnum * randnum2) - randnum3) % 10 == 0 ):
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run_Right")
		velocity.x = min(velocity.x + ACC, SPEED)
	elif( ( (randnum * randnum2) - randnum3) % 10 == 1):
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run_Left")
		velocity.x = max(velocity.x - ACC, -SPEED)
	else: 
		$AnimatedSprite.play("Idle")
		
	move_and_slide(velocity)
	velocity.x = lerp(velocity.x,0,0.15)
