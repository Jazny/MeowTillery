extends Panel

var default_tex = preload("res://Inventory/item_slot_default_background.png")
var empty_tex = preload("res://Inventory/item_slot_empty_background.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Inventory/Test_Item.tscn")
var Item = null
var slot_index

# Called when the node enters the scene tree for the first time.
func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	refresh_style()

func refresh_style():
	if Item == null:
		set('custom_styles/panel', empty_style)
	else:
		set('custom-styles/panel', default_style)

func pick_from_slot():
	remove_child(Item)
	var InventoryNode = find_parent("Inventory")
	InventoryNode.add_child(Item)
	Item = null
	refresh_style()

func put_into_slot(nuItem):
	Item = nuItem
	Item.position = Vector2(0,0)
	var InventoryNode = find_parent("Inventory")
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
