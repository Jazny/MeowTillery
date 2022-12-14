extends Node2D

const SlotClass = preload("Inventory_Panel.gd")
onready var inventory_slots = $GridContainer
onready var equip_slots = $EquipSlots.get_children()

 
func _ready():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		slots[i].connect("gui_input", self, "slot_gui_input", [slots[i]])
		slots[i].slot_index = i
		slots[i].slotType = SlotClass.SlotType.INVENTORY
	for i in range(equip_slots.size()):
		equip_slots[i].connect("gui_input", self, "slot_gui_input", [equip_slots[i]])
		equip_slots[i].slot_index = i
	equip_slots[0].slotType = SlotClass.SlotType.SHIRT
	equip_slots[1].slotType = SlotClass.SlotType.PANTS
	equip_slots[2].slotType = SlotClass.SlotType.SHOES
	equip_slots[3].slotType = SlotClass.SlotType.WEAPONS
	
	intialize_inventory()
	initialize_equips()

func intialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].intialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func initialize_equips():
	for i in range(equip_slots.size()):
		if PlayerInventory.equips.has(i):
			equip_slots[i].intialize_item(PlayerInventory.equips[i][0], PlayerInventory.equips[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			if find_parent("HUD").holding_item != null:
				if !slot.Item:
					left_click_empty_slot(slot)
				else:
					if find_parent("HUD").holding_item.item_name != slot.Item.item_name:
						left_click_different_item(event, slot)
					else:
						left_click_same_item(slot)
			elif slot.Item:
				left_click_not_holding(slot)

func able_to_put_into_slot(slot: SlotClass):
	var holding_item = find_parent("HUD").holding_item
	if holding_item == null:
		return true
	var holding_item_category = JsonData.item_data[holding_item.item_name]["ItemCategory"]
	
	if slot.slotType == SlotClass.SlotType.SHIRT:
		return holding_item_category == "Shirt"
	elif slot.slotType == SlotClass.SlotType.PANTS:
		return holding_item_category == "Pants"
	elif slot.slotType == SlotClass.SlotType.SHOES:
		return holding_item_category == "Shoes"
	elif slot.slotType == SlotClass.SlotType.WEAPONS:
		return holding_item_category == "Weapon"
	return true

func left_click_empty_slot(slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.add_item_to_empty_slot(find_parent("HUD").holding_item, slot)
		slot.put_into_slot(find_parent("HUD").holding_item)
		find_parent("HUD").holding_item = null

func left_click_different_item(event: InputEvent, slot: SlotClass):
	if able_to_put_into_slot(slot):
		PlayerInventory.remove_item(slot)
		PlayerInventory.add_item_to_empty_slot(find_parent("HUD").holding_item, slot)
		var temp_item = slot.Item
		slot.pick_from_slot()
		temp_item.global_position = event.global_position
		slot.put_into_slot(find_parent("HUD").holding_item)
		find_parent("HUD").holding_item = temp_item

func left_click_same_item(slot: SlotClass):
	if able_to_put_into_slot(slot):
		var stack_size = int(JsonData.item_data[slot.Item.item_name]["StackSize"])
		var able_to_add = stack_size - slot.Item.item_quantity
		if able_to_add >= find_parent("HUD").holding_item.item_quantity:
			PlayerInventory.add_item_quantity(slot, find_parent("HUD").holding_item.item_quantity)
			slot.Item.add_item_quantity(find_parent("HUD").holding_item.item_quantity)
			find_parent("HUD").holding_item.queue_free()
			find_parent("HUD").holding_item = null
		else:
			PlayerInventory.add_item_quantity(slot, able_to_add)
			slot.Item.add_item_quantity(able_to_add)
			find_parent("HUD").holding_item.decrease_item_quantity(able_to_add)

func left_click_not_holding(slot: SlotClass):
	PlayerInventory.remove_item(slot)
	find_parent("HUD").holding_item = slot.Item
	slot.pick_from_slot()
	find_parent("HUD").holding_item.global_position = get_global_mouse_position()

func _input(event):
	if find_parent("HUD").holding_item:
		find_parent("HUD").holding_item.global_position = get_global_mouse_position()
