extends Panel

var default_tex = preload("res://Inventory/item_slot_default_background.png")
var empty_tex = preload("res://Inventory/item_slot_empty_background.png")

var default_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass = preload("res://Inventory/Test_Item.tscn")
var Item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	
	if randi() % 25 == 1:
		Item = ItemClass.instance()
		add_child(Item)
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
	
