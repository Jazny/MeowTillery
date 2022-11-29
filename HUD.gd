extends CanvasLayer


var holding_item = null


func _input(event):
	if event.is_action_pressed("Inventory"):
		$Inventory.visible = !$Inventory.visible
		$Inventory.intialize_inventory()
	
	if event.is_action_pressed("scroll_up"):
		PlayerInventory.active_item_scroll_down()
	elif event.is_action_pressed("scroll_down"):
		PlayerInventory.active_item_scroll_up()
	elif event.is_action_pressed("Hotbar_Slot_1"):
		PlayerInventory.active_item_1() 
	elif event.is_action_pressed("Hotbar_Slot_2"):
		PlayerInventory.active_item_2()
	elif event.is_action_pressed("Hotbar_Slot_3"):
		PlayerInventory.active_item_3()
	elif event.is_action_pressed("Hotbar_Slot_4"):
		PlayerInventory.active_item_4()
	elif event.is_action_pressed("Hotbar_Slot_5"):
		PlayerInventory.active_item_5()
	elif event.is_action_pressed("Hotbar_Slot_6"):
		PlayerInventory.active_item_6()
	elif event.is_action_pressed("Hotbar_Slot_7"):
		PlayerInventory.active_item_7()
	elif event.is_action_pressed("Hotbar_Slot_8"):
		PlayerInventory.active_item_8()

func _ready():
	pass
