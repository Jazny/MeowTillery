extends Control

onready var sanity_bar = $Sanity
#signal killed()

func _ready():
	PlayerStat.connect("sanity_updated", self, "_sanity_update")
	_sanity_update(PlayerStat.sanity)

func _sanity_update(sanity):
	sanity_bar.value = sanity

func _on_Timer_timeout():
	if(get_tree().get_current_scene().get_name() == "World"):
		PlayerStat._set_sanity(PlayerStat.sanity-1)
	if(get_tree().get_current_scene().get_name() == "Cafe_Scene"):
		PlayerStat._set_sanity(PlayerStat.sanity+1)
	if(get_tree().get_current_scene().get_name() == "World_cat_dungeon"):
		PlayerStat._set_sanity(PlayerStat.sanity+1)
	if(get_tree().get_current_scene().get_name() == "bedroom_scene"):
		PlayerStat._set_sanity(PlayerStat.sanity+1)

