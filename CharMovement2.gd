extends KinematicBody2D
const SlotClass = preload("Inventory_Panel.gd")


const MOVE_SPEED = 500
const ACC = 80
const JUMP_FORCE = 1000
const WALL_JUMP_FORCE = 600
const GRAVITY = 50
const TERMINAL_VELOCITY = 1000
const WALL_SLIDE_SPEED = 40
const DASH_FORCE = 2500

onready var sprite = $Sprite
var yVelocity = 0
var xVelocity = 0
var lookingRight = false

const invincibility_duration = 1.5
onready var hurtbox = $Hurtbox
onready var blinker = $Blinker
var stats = PlayerStat

var spacer = 0
var stateJ = "idle"
var stateR = "idle"

var stateW = "sword"
var stateW2 = "Catlass"
## stateW: either "gun" or "sword" or "none"
## stateW2: either "ACat-47" or "MeowchineGun" or "Catana" or "Catlass" or "none"

func _ready():
	stats.connect("killed", self, "_die")

func _physics_process(delta):
	get_tree().call_group("need_player", "set_player", self)
	var onFloor = is_on_floor()
	var onWall = is_on_wall()
	var onCeiling = is_on_ceiling()
	
	if(onFloor and stateR != "dead"):
		stateJ = "idle"
	if(onCeiling):
		yVelocity = 0
	if(onWall):
		xVelocity = 0
		
	if(onWall and Input.is_action_pressed("mv_wall_slide")  and stateR != "dead" ):
		if(lookingRight):
			xVelocity = 5
		else:
			xVelocity = -5
			
	if(Input.is_action_pressed("mv_right") and stateR != "dead"):
		xVelocity = min(xVelocity + ACC, MOVE_SPEED)
		stateR = "running"
	if(Input.is_action_pressed("mv_left")  and stateR != "dead"):
		xVelocity = max(xVelocity - ACC, -MOVE_SPEED)
		stateR = "running"
	if(onFloor and Input.is_action_just_pressed("mv_jump") and !onCeiling  and stateR != "dead"):
		stateJ = "jump1"
		yVelocity = -JUMP_FORCE
	if(stateJ == "jump1" and Input.is_action_just_pressed("mv_jump") and !onFloor and !onCeiling ):
		stateJ = "jump2"
		yVelocity = -JUMP_FORCE
	if(onWall and (stateJ == "jump1" or stateJ == "jump2") and Input.is_action_pressed("mv_wall_slide")):
		yVelocity = WALL_SLIDE_SPEED
		stateJ = "jump2"
	if(onWall and Input.is_action_just_pressed("mv_jump") and Input.is_action_pressed("mv_wall_slide") ):
		wallJump()
		
	move_and_slide(Vector2(xVelocity, yVelocity), Vector2(0, -1))
	if(onFloor):
		xVelocity = lerp(xVelocity,0,0.15)
	
	if(lookingRight and xVelocity < 0):
		flip()
	if(!lookingRight and xVelocity > 0):
		flip()
	
	yVelocity += GRAVITY
	if(yVelocity > TERMINAL_VELOCITY):
		yVelocity = TERMINAL_VELOCITY
	if(onFloor and yVelocity >= 5):
		yVelocity = 5
	
	if(stateW == "gun"):
		_shoot()
		
	if(stateW == "sword"):
		_stab()
	
	#check()
	animate()
		
func flip():
	lookingRight = !lookingRight
	sprite.flip_h = !sprite.flip_h
	if(get_node("CatanaHitBox").position.x < 0):
		get_node("CatanaHitBox").position.x = 30
		get_node("CatlassHitBox").position.x = 30
	elif(get_node("CatanaHitBox").position.x > 0):
		get_node("CatanaHitBox").position.x = -5.637
		get_node("CatlassHitBox").position.x = -5.637
	

func animate():
	
	
	if(stateR == "dead"):
		sprite.play("death")
		return
	elif(is_on_wall() and (stateJ == "jump1" or stateJ == "jump2") and Input.is_action_pressed("mv_wall_slide")):
		sprite.play("Wall Slide")
		return
		
	elif(stateW == "none"):
		if(Input.is_action_just_pressed("mv_jump")):
			sprite.play("Jump")
			return
		elif(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
			sprite.play("Run")
			return
		elif(Input.is_action_just_released("mv_right") or Input.is_action_just_released("mv_left")):
			sprite.play("Idle")
			return
		if(xVelocity == 0 and yVelocity <= 5):
			sprite.play("Idle")
			
	elif(stateW == "gun" and stateW2 == "ACat-47"):
		if(Input.is_action_just_pressed("mv_jump")):
			sprite.play("jump+ACat-47")
			return
		elif(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
			sprite.play("run+ACat47")
			return
		elif(Input.is_action_just_released("mv_right") or Input.is_action_just_released("mv_left")):
			sprite.play("idle+ACat-47")
			return
		if(xVelocity == 0 and yVelocity <= 5):
			sprite.play("idle+ACat-47")
			
	elif(stateW == "gun" and stateW2 == "MeowchineGun"):
		if(Input.is_action_just_pressed("mv_jump")):
			sprite.play("jump+meowchinegun")
			return
		elif(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
			sprite.play("run+meowchinegun")
			return
		elif(Input.is_action_just_released("mv_right") or Input.is_action_just_released("mv_left")):
			sprite.play("idle+meowchinegun")
			return
		if(xVelocity == 0 and yVelocity <= 5):
			sprite.play("idle+meowchinegun")
	
	elif(stateW == "sword" and stateW2 == "Catana"):
		if(Input.is_action_just_pressed("mv_jump")):
			sprite.play("jump+catana")
			return
		elif(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
			sprite.play("run+catana")
			return
		elif(Input.is_action_just_released("mv_right") or Input.is_action_just_released("mv_left")):
			sprite.play("idle+catana")
			return
		if(xVelocity == 0 and yVelocity <= 5):
			sprite.play("idle+catana")
			
	elif(stateW == "sword" and stateW2 == "Catlass"):
		if(Input.is_action_just_pressed("mv_jump")):
			sprite.play("jump+catlass")
			return
		elif(Input.is_action_pressed("mv_right") or Input.is_action_pressed("mv_left")):
			sprite.play("run+catlass")
			return
		elif(Input.is_action_just_released("mv_right") or Input.is_action_just_released("mv_left")):
			sprite.play("idle+catlass")
			return
		if(xVelocity == 0 and yVelocity <= 5):
			sprite.play("idle+catlass")

func check():
	if PlayerInventory.equips.empty() == true:
		stateW = "none"
		stateW2 = "none"
	else:
		if PlayerInventory.equips[3][0] == "MeowchineGun" or PlayerInventory.equips[3][0] == "ACat-47":
			stateW = "gun"
			stateW2 = PlayerInventory.equips[3][0]
		elif PlayerInventory.equips[3][0] == "Catana" or PlayerInventory.equips[3][0] == "Catlass":
			stateW = "sword"
			stateW2 = PlayerInventory.equips[3][0]


func wallJump():
	yVelocity = -JUMP_FORCE / 2
	if(lookingRight):
		xVelocity = -WALL_JUMP_FORCE
		stateJ = "jump2"
	else:
		xVelocity = WALL_JUMP_FORCE
		stateJ = "jump2"
		
func _stab():
	if(stateW2 == "Catana" and Input.is_action_just_pressed("shoot")):
		sprite.play("hit+catana")
		get_node("CatanaHitBox").get_node("CollisionShape2D").disabled = false
		
		yield(get_tree().create_timer(0.5), "timeout")
		
		get_node("CatanaHitBox").get_node("CollisionShape2D").disabled = true
	
	if(stateW2 == "Catlass" and Input.is_action_pressed("shoot")):
		sprite.play("hit+catlass")
		get_node("CatlassHitBox").get_node("CollisionShape2D").disabled = false
		
		yield(get_tree().create_timer(0.5), "timeout")
		
		get_node("CatlassHitBox").get_node("CollisionShape2D").disabled = true
	

func _shoot():
	if(stateW2 == "ACat-47" and Input.is_action_just_pressed("shoot")):
		sprite.play("hit+ACat-47")
		var projectileACat = preload("res://ACatProjectile.tscn")
		var projInstanceACat = projectileACat.instance()
		get_tree().get_root().add_child(projInstanceACat)
		
		if(lookingRight == true):
			projInstanceACat.global_position.x = global_position.x + 50
			projInstanceACat.global_position.y = global_position.y
			projInstanceACat.movement = Vector2(1, 0)
		if(lookingRight == false):
			projInstanceACat.global_position.x = global_position.x - 50
			projInstanceACat.global_position.y = global_position.y
			projInstanceACat.movement = Vector2(-1, 0)
		yield(get_tree().create_timer(0.5), "timeout")
			
			
	if(stateW2 == "MeowchineGun" and Input.is_action_pressed("shoot")):
		sprite.play("hit+meowchinegun")
		var projectileACat = preload("res://MeowchineGunProjectile.tscn")
		var projInstanceACat = projectileACat.instance()
		if(spacer > 5):
			get_tree().get_root().add_child(projInstanceACat)
			if(lookingRight == true):
				projInstanceACat.global_position.x = global_position.x + 50
				projInstanceACat.global_position.y = global_position.y
				projInstanceACat.movement = Vector2(1, 0)
			if(lookingRight == false):
				projInstanceACat.global_position.x = global_position.x - 50
				projInstanceACat.global_position.y = global_position.y
				projInstanceACat.movement = Vector2(-1, 0)
			yield(get_tree().create_timer(0.5), "timeout")
			spacer = 0
		spacer = spacer + 1
		
		
func _die():
	stateJ = "dead"
	stateR = "dead"
	$Particles2D.emitting = true
	$Sprite.play("Death")
	yield(get_tree().create_timer(2), "timeout")
	get_tree().change_scene("res://Main_Menu.tscn")
	
func _on_Hurtbox_area_entered(area):
	if area.damage != 0:
		if !hurtbox.is_invincible:
			blinker.start_blinking(self, invincibility_duration)
			hurtbox.start_invincibility(invincibility_duration)
			stats.health-=area.damage


func _on_SanityBar_killed():
	_die()


func _on_Sprite_animation_finished():
	sprite.play("Idle")

func _input(event):
	if event.is_action_pressed("pickup"):
		if $PickupZone.items_in_range.size() > 0:
			var pickup_item = $PickupZone.items_in_range.values()[0]
			pickup_item.pick_up_item(self)
			$PickupZone.items_in_range.erase(pickup_item)
