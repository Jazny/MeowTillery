extends Panel

var default_tex = preload("res://Inventory/item_slot_default_background.png")
var empty_tex = preload("res://Inventory/item_slot_empty_background.png")
var selected_tex = preload("res://Inventory/item_slot_selected_background.png") #This line is new


var selected_style: StyleBoxTexture = null #This line is new
var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Inventory/Test_Item.tscn")
var Item = null
var slot_index
#Everything to the next cooment needs to be added
enum SlotType {
	HOTBAR = 0,
	INVENTORY,
	SHIRT,
	PANTS,
	SHOES,
}
var slotType = null
# Called when the node enters the scene tree for the first time, so everything above this comment.
func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	selected_style = StyleBoxTexture.new()#This probably needs to be added
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	selected_style.texture = selected_tex#This also porbably needs to be added
	
	refresh_style()

func refresh_style():
	if slotType == SlotType.HOTBAR and PlayerInventory.active_item_slot == slot_index: #This if statement needs to be there
		set('custom_styles/panel', selected_style) #This needs to be there
	elif Item == null:
		set('custom_styles/panel', empty_style) #This, for you, needs to be changed from an if to an elif
	else:
		set('custom_styles/panel', default_style)

func pick_from_slot():
	remove_child(Item)
	var InventoryNode = find_parent("HUD") #Needs to be added
	InventoryNode.add_child(Item)
	Item = null
	refresh_style()

func put_into_slot(nuItem):
	Item = nuItem
	Item.position = Vector2(0,0)
	var InventoryNode = find_parent("HUD") #Needs to be added
	InventoryNode.remove_child(Item)
	add_child(Item)
	refresh_style()
	
func intialize_item(item_name, item_quantity):
	if Item == null:
		Item = ItemClass.instance()
		add_child(Item)
		Item.set_item(item_name, item_quantity)
	else:
		Item.set_item(item_name, item_quantity)
	refresh_style()
