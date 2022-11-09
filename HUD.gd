extends CanvasLayer


func _input(event):
	if event.is_action_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.intialize_inventory()
func _ready():
	pass
