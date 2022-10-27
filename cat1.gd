extends KinematicBody2D

var velocity = 40
var motion = Vector2()
var gravity = 50
var moving_left = true
onready var my_timer = get_node("Timer")

func _ready():
	$AnimatedSprite.play("walk")
	$Timer.wait_time = 9.0
	$Timer.start()
	$Timer.paused = false

# warning-ignore:unused_argument
func _physics_process(delta):	
	if ($left_ray.is_colliding()):
		moving_left = false
		$AnimatedSprite.flip_h = true
	if ($right_ray.is_colliding()):
		moving_left = true
		$AnimatedSprite.flip_h = false
	
	motion.y += gravity
	if (moving_left == true):
		motion.x = (-1 * velocity)
	else:
		motion.x = velocity

	motion = move_and_slide(motion)


func _on_Timer_timeout():
	var velocity_buff = velocity
	velocity = 0
	$AnimatedSprite.play("sit") # play sit animation
	yield(get_tree().create_timer(1), "timeout") # stay in sit animation set time
	$AnimatedSprite.play("idle") # play idle animation
	yield(get_tree().create_timer(5), "timeout") #stay in idle animation for set time
	$AnimatedSprite.play("stand") # play stand animation
	yield(get_tree().create_timer(1), "timeout") # stay in stand animation for set time
	$AnimatedSprite.play("walk") #go back to walk
	velocity = velocity_buff
	$Timer.start()
