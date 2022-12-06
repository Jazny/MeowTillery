extends Node

signal active_item_updated

const SlotClass = preload("Inventory_Panel.gd")
const ItemClass = preload("Inventory/Test_Item.gd")
const NUM_INVENTORY_SLOTS = 25
const NUM_HOTBAR_SLOTS = 8

var active_item_slot = 0


var inventory = {
	0: ["MeowchineGun", 1]
}

var hotbar = {
	0: ["Tree Branch", 1],  #--> slot_index: [item_name, item_quantity]
}

var equips = {
}


func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - able_to_add
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return

func update_slot_visual(slot_index, item_name, neoquantity):
	var name = get_tree().get_current_scene().get_name()
	var slot = get_tree().root.get_node("/root/" + str(name) + "/HUD/Inventory/GridContainer/Panel" + str(slot_index+1))
	if slot.Item == null:
		slot.intialize_item(item_name, neoquantity)
	else:
		slot.Item.set_item(item_name, neoquantity)

func remove_item(slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.HOTBAR:
			hotbar.erase(slot.slot_index)
		SlotClass.SlotType.INVENTORY:
			inventory.erase(slot.slot_index)
		_:
			equips.erase(slot.slot_index)


func add_item_to_empty_slot(Item: ItemClass, slot: SlotClass):
	match slot.slotType:
		SlotClass.SlotType.HOTBAR:
			hotbar[slot.slot_index] = [Item.item_name, Item.item_quantity]
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index] = [Item.item_name, Item.item_quantity]
		_:
			equips[slot.slot_index] = [Item.item_name, Item.item_quantity]

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	match slot.slotType:
		SlotClass.SlotType.HOTBAR:
			hotbar[slot.slot_index][1] += quantity_to_add
		SlotClass.SlotType.INVENTORY:
			inventory[slot.slot_index][1] += quantity_to_add
		_:
			equips[slot.slot_index][1] += quantity_to_add

func active_item_scroll_up() -> void:
	active_item_slot = (active_item_slot + 1) % NUM_HOTBAR_SLOTS
	emit_signal("active_item_updated")

func active_item_scroll_down() -> void:
	if active_item_slot == 0:
		active_item_slot = NUM_HOTBAR_SLOTS - 1
	else:
		active_item_slot -= 1
	emit_signal("active_item_updated")

func active_item_1():
	active_item_slot = 0
	emit_signal("active_item_updated")

func active_item_2():
	active_item_slot = 1
	emit_signal("active_item_updated")

func active_item_3():
	active_item_slot = 2
	emit_signal("active_item_updated")

func active_item_4():
	active_item_slot = 3
	emit_signal("active_item_updated")

func active_item_5():
	active_item_slot = 4
	emit_signal("active_item_updated")

func active_item_6():
	active_item_slot = 5
	emit_signal("active_item_updated")

func active_item_7():
	active_item_slot = 6
	emit_signal("active_item_updated")

func active_item_8():
	active_item_slot = 7
	emit_signal("active_item_updated")
