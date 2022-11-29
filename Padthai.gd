extends KinematicBody2D

export var damage = 0

var motion = Vector2()

#const GRAVITY = 50

func _physics_process(delta):
	motion.y += 10
	move_and_slide(motion)


"""
func _on_PtArea_body_entered(body):
	if(body.name != "Squango"):
		self.get_node("CollisionShape2D").set_deferred("disabled", true)
		self.get_node("PtArea/CollisionShape2D").set_deferred("disabled", true)


func _on_PtArea_body_exited(body):
	if(body.name != "Squango"):
		self.get_node("CollisionShape2D").set_deferred("disabled", false)
		self.get_node("PtArea/CollisionShape2D").set_deferred("disabled", false)
"""

"""func _on_PtArea_area_entered(area):
	if(area.name != "Hurtbox"):
		self.get_node("CollisionShape2D").set_deferred("disabled", true)
		self.get_node("PtArea/CollisionShape2D").set_deferred("disabled", true)


func _on_PtArea_area_exited(area):
	if(area.name != "Squango"):
		self.get_node("CollisionShape2D").set_deferred("disabled", false)
		self.get_node("PtArea/CollisionShape2D").set_deferred("disabled", false)
"""
