extends Node2D



@onready var menu = get_node("PauseMenu")

#stats of turrets, in order by Power,Ammo,Energy,Reload speed,HP
var stats = {"Pur":[10,13,125,2.5,130], "Yellow":[5,35,150,3.5,130],"Bob":[16,7,50,1,225],"Gem":[33,5,275,4.5,100],"Pete":[5,20,200,1.5,175]}
# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	setUpGame()
	$"AnimationPlayer".play("Intro")

@onready var player = get_node("PlayerTurret")
@onready var enemy = get_node("EnemyTurret")

func setUpGame():
	$"Background".frame = randi()%3
	
	var enemyChar = Gobal.enemy[Gobal.level]
	if enemyChar == "win":
		get_tree().paused = false
		Gobal.level = 0
		get_tree().change_scene_to_file("res://Scenes/Thanks.tscn")
	else:
		var playerStat = stats[Gobal.character]
		var enemyStat = stats[enemyChar]
		#set sprites
		player.animation = Gobal.character
		player.frame = 1
		enemy.animation = enemyChar
		enemy.frame = 1
		$"Intro/ShowCase".animation = enemy.animation
		$"Intro/ShowCase".frame = 1
		
		#set damage
		player.Odamage = playerStat[0]
		enemy.Odamage = enemyStat[0]
		
		#set Ammo
		player.MaxAmmo = playerStat[1]
		enemy.MaxAmmo = enemyStat[1]
		player.Ammo = player.MaxAmmo
		enemy.Ammo = enemy.MaxAmmo
		
		#set energy
		player.energybar.max_value = playerStat[2]
		player.energybar.value = playerStat[2]
		enemy.energybar.max_value = enemyStat[2] * (Gobal.diff +1)
		enemy.energybar.value = enemyStat[2] * (Gobal.diff +1)
		
		#set health
		player.healthbar.max_value = playerStat[4]
		player.healthbar.value = playerStat[4]
		enemy.healthbar.max_value = enemyStat[4] + (Gobal.diff * 35)
		enemy.healthbar.value = enemyStat[4] + (Gobal.diff * 35)
		
		#set ReloadTime
		player.get_node("ReloadTime").wait_time = playerStat[3]
		enemy.get_node("ReloadTime2").wait_time = enemyStat[3] / (Gobal.diff +1)
		
		#set enemyInfo
		$"Intro/Label".text = Gobal.info[enemyChar][0]
		$"Intro/Label2".text = Gobal.info[enemyChar][1]




func _on_Pause_pressed():
	get_tree().paused = true
	menu.visible = true

func _on_Resume_pressed():
	get_tree().paused = false
	menu.visible = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Intro" or anim_name == "Ablity":
		get_tree().paused = false
