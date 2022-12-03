extends Node

onready var entrance
onready var exit 
onready var cafe_to_dungeon
onready var dungeon_to_bedroom

func _ready():
	entrance = false
	exit = false
	cafe_to_dungeon = false
	dungeon_to_bedroom = false
