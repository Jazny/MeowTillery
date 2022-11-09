extends Node

const SlotClass = preload("Inventory_Panel.gd")
const ItemClass = preload("Inventory/Test_Item.gd")
const NUM_INVENTORY_SLOTS = 20

var inventory = {
	0: ["Tree Branch", 1]
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
	var slot = get_tree().root.get_node("/root/World/HUD/Inventory/GridContainer/Panel" + str(slot_index+1))
	if slot.Item == null:
		slot.intialize_item(item_name, neoquantity)
	else:
		slot.Item.set_item(item_name, neoquantity)

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)

func add_item_to_empty_slot(Item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [Item.item_name, Item.item_quantity]

func add_item_quantity(slot: SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
