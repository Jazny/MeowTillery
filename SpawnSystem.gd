extends Node2D


# Declare member variables here

var minion = preload("res://minion.tscn")
var jenner = preload("res://Kendall_Jenner.tscn")
var scrum = preload("res://Robert_Scrum.tscn")
var ingrid = preload("res://Ingrid.tscn")
var turret = preload("res://Turret.tscn")
var BB = preload("res://BossBar.tscn")
var MBB = preload("res://MiniBossBar.tscn")
var doorBlock = preload("res://DoorBlocker.tscn")
var wavestarted = 0
var blockFreed = 0

var block = doorBlock.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	wavestarted = 0
	_newWave()

func _newWave():
	
	match(WaveTracker.waveNum):
		1:
			var minion1 = minion.instance()
			var minion2 = minion.instance()
			var minion3 = minion.instance()
			var minion4 = minion.instance()
			var minion5 = minion.instance()
			
			minion1.position = Vector2(-300, 60)
			minion2.position = Vector2(-350, 60)
			minion3.position = Vector2(-400, 60)
			minion4.position = Vector2(400, 60)
			minion5.position = Vector2(450, 60)
			
			minion1.is_moving_right = true
			minion1.scale.x = -minion1.scale.x
			minion2.is_moving_right = true
			minion2.scale.x = -minion2.scale.x
			minion3.is_moving_right = true
			minion3.scale.x = -minion3.scale.x
			
			add_child(minion1)
			add_child(minion2)
			add_child(minion3)
			add_child(minion4)
			add_child(minion5)
			
			WaveTracker.enemiesRemaining = 5
			
		2:
			var minion1 = minion.instance()
			var minion2 = minion.instance()
			var minion3 = minion.instance()
			var jenner1 = jenner.instance()
			var jenner2 = jenner.instance()
			var jenner3 = jenner.instance()
			
			minion1.position = Vector2(-200, 60)
			minion2.position = Vector2(-250, 60)
			minion3.position = Vector2(-300, 60)
			jenner1.position = Vector2(-350, 60)
			jenner2.position = Vector2(-400, 60)
			jenner3.position = Vector2(-150, 60)
			
			minion1.is_moving_right = true
			minion1.scale.x = -minion1.scale.x
			minion2.is_moving_right = true
			minion2.scale.x = -minion2.scale.x
			minion3.is_moving_right = true
			minion3.scale.x = -minion3.scale.x
			jenner1.is_moving_right = true
			jenner1.scale.x = -jenner1.scale.x
			jenner2.is_moving_right = true
			jenner2.scale.x = -jenner2.scale.x
			jenner3.is_moving_right = true
			jenner3.scale.x = -jenner3.scale.x
			
			add_child(minion1)
			add_child(minion2)
			add_child(minion3)
			add_child(jenner1)
			add_child(jenner2)
			add_child(jenner3)
			
			WaveTracker.enemiesRemaining = 6
		3:
			var minion1 = minion.instance()
			var minion2 = minion.instance()
			var minion3 = minion.instance()
			var minion4 = minion.instance()
			var minion5 = minion.instance()
			var robert = scrum.instance()
			
			var TheMiniBossBar = MBB.instance()
			
			
			minion1.position = Vector2(-200, 60)
			minion2.position = Vector2(-250, 60)
			minion3.position = Vector2(-300, 60)
			robert.position = Vector2(-350, 60)
			minion4.position = Vector2(-400, 60)
			minion5.position = Vector2(-450, 60)
			TheMiniBossBar.rect_position = Vector2(400,480)
			
			minion1.is_moving_right = true
			minion1.scale.x = -minion1.scale.x
			minion2.is_moving_right = true
			minion2.scale.x = -minion2.scale.x
			minion3.is_moving_right = true
			minion3.scale.x = -minion3.scale.x
			
			add_child(minion1)
			add_child(minion2)
			add_child(minion3)
			add_child(minion4)
			add_child(minion5)
			add_child(robert)
			

			get_parent().get_node("HUD").get_node("Interface").add_child(TheMiniBossBar)
			robert.get_node("Robert_Scrum_Stats").connect("health_updated",TheMiniBossBar, "_on_Robert_Scrum_Stats_health_updated")
			robert.get_node("Robert_Scrum_Stats").connect("killed", TheMiniBossBar, "queue_free")
			

			WaveTracker.enemiesRemaining = 6

		4:
			var minion1 = minion.instance()
			var minion2 = minion.instance()
			var minion3 = minion.instance()
			var minion4 = minion.instance()
			var minion5 = minion.instance()
			
			
			minion1.position = Vector2(-200, 60)
			minion2.position = Vector2(-250, 60)
			minion3.position = Vector2(-300, 60)
			minion4.position = Vector2(-400, 60)
			minion5.position = Vector2(-450, 60)
			
			minion1.is_moving_right = true
			minion1.scale.x = -minion1.scale.x
			minion2.is_moving_right = true
			minion2.scale.x = -minion2.scale.x
			minion3.is_moving_right = true
			minion3.scale.x = -minion3.scale.x
			
			add_child(minion1)
			add_child(minion2)
			add_child(minion3)
			add_child(minion4)
			add_child(minion5)

			
			WaveTracker.enemiesRemaining = 5

		5:
			var minion1 = minion.instance()
			var minion2 = minion.instance()
			var minion3 = minion.instance()
			var minion4 = minion.instance()
			var jenner1 = jenner.instance()
			var jenner2 = jenner.instance()
			var jenner3 = jenner.instance()
			var turret1 = turret.instance()
			var turret2 = turret.instance()
			
			minion1.position = Vector2(-150, 60)
			jenner1.position = Vector2(-200, 60)
			minion2.position = Vector2(-250, 60)
			jenner2.position = Vector2(-300, 60)
			minion3.position = Vector2(-350, 60)
			jenner3.position = Vector2(-375, 60)
			minion4.position = Vector2(-400, 60)
			turret1.position = Vector2(250, 0)
			turret2.position = Vector2(0, 0)
			
			minion1.is_moving_right = true
			minion1.scale.x = -minion1.scale.x
			minion2.is_moving_right = true
			minion2.scale.x = -minion2.scale.x
			minion3.is_moving_right = true
			minion3.scale.x = -minion3.scale.x
			minion4.is_moving_right = true
			minion4.scale.x = -minion4.scale.x
			
			add_child(minion1)
			add_child(minion2)
			add_child(minion3)
			add_child(minion4)
			add_child(jenner1)
			add_child(jenner2)
			add_child(jenner3)
			add_child(turret1)
			add_child(turret2)
			
			WaveTracker.enemiesRemaining = 9
		6:
			#this should be robert scrum 2 btw
			var robert = scrum.instance()
			var jenner1 = jenner.instance()
			var jenner2 = jenner.instance()
			var jenner3 = jenner.instance()
			var turret1 = turret.instance()
			var turret2 = turret.instance()
			var turret3 = turret.instance()
			
			robert.position = Vector2(-350, 60)
			jenner1.position = Vector2(-200, 60)
			jenner2.position = Vector2(-300, 60)
			jenner3.position = Vector2(-375, 60)
			turret1.position = Vector2(250, 0)
			turret2.position = Vector2(0, 0)
			turret3.position = Vector2(-250, 0)
			
			add_child(jenner1)
			add_child(jenner2)
			add_child(jenner3)
			add_child(turret1)
			add_child(turret2)
			add_child(turret3)
			add_child(robert)
			
			WaveTracker.enemiesRemaining = 7
		7:
			var TheIngrid = ingrid.instance()
			var TheBossBar = BB.instance()
			
			TheIngrid.position = Vector2(-350, 60)
			TheBossBar.rect_position = Vector2(400,480)
			
			add_child(TheIngrid)
			get_parent().get_node("HUD").get_node("Interface").add_child(TheBossBar)
			TheIngrid.get_node("Ingrid_Stats").connect("health_updated",TheBossBar, "_on_Ingrid_Stats_health_updated")
			TheIngrid.get_node("Ingrid_Stats").connect("killed", TheBossBar, "queue_free")
			
			WaveTracker.enemiesRemaining = 1


func _process(delta):

	if (!wavestarted):
		block.position = Vector2(475,115)
		add_child(block)
		wavestarted = 1
		
	if (WaveTracker.enemiesRemaining == 0 && !blockFreed):
		print("wave cleared")
		block.queue_free()
		blockFreed = 1
