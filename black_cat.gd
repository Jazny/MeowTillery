extends KinematicBody2D

var velocity = 40
var motion = Vector2()
var gravity = 50
var moving_left = true

func _ready():
	$AnimatedSprite.play("idle")
