extends Node2D

const SlotClass = preload("Inventory_Panel.gd")
onready var inventory_slots = $GridContainer
var holding_item = null
 
func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.connect("gui_input", self, "slot_gui_input", [inv_slot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.Item:
					slot.put_into_slot(holding_item)
					holding_item = null
				else:
					var stack_size = int(JsonData.item_data[slot.Item.item_name]["StackSize"])
					var able_to_add = stack_size - slot.Item.item_quantity
					if able_to_add >= holding_item.item_quantity:
						slot.Item.add_item_quantity(holding_item.item_quantity)
						holding_item.queue_free()
						holding_item = null
					else:
						slot.Item.add_item_quantity(able_to_add)
						holding_item.decrease_item_quantity(able_to_add)
			elif slot.Item:
				holding_item = slot.Item
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
