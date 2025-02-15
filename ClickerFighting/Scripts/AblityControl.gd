extends Node2D

@onready var player = $"../PlayerTurret"
@onready var enemy = $"../EnemyTurret"
@onready var voice = $"../VoiceLines"
@onready var voice2 = $"../VoiceLines2"
@onready var tower = $"../TowerClose"
var enemyChar = Gobal.enemy[Gobal.level]
var playerChar = Gobal.character

func triggerVoice(chara, ready):
	get_tree().paused = true
	if ready:
		pass
	elif !ready:
		if chara == "Bob":
			voice.stream = load("res://Audio/BobUse.wav")
		elif chara == "Gem":
			#voice.stream = load("res://Audio/BobUse.wav")
			pass
		elif chara == "Yellow":
			#voice.stream = load("res://Audio/BobUse.wav")
			pass
		elif chara == "Pur":
			#voice.stream = load("res://Audio/BobUse.wav")
			pass
		elif chara == "Pete":
			#voice.stream = load("res://Audio/BobUse.wav")
			pass
		tower.animation = chara
		tower.frame = 1
		$"../AnimationPlayer".play("Ablity")
	if !Gobal.mute:
		voice2.stop()
		voice.play()

func triggerthing(value):
	var playerinfo = [player,playerChar,get_node("EnemyTime")]
	var enemyinfo = [enemy,enemyChar,get_node("PlayerTime")]
	if value.thing == false:
		return
	var opp
	var chara
	if value == player:
		opp = enemyinfo
		chara = playerinfo[1]
	else:
		opp = playerinfo
		chara = enemyinfo[1]
		
	if chara == "Pur":
		opp[0].Ammo = 0
	elif chara == "Yellow":
		value.MaxAmmo = 999
		value.Ammo = value.MaxAmmo
		value.get_child(4).stop()
		value.get_child(0).text = "Ammo: " + str(value.MaxAmmo)
		opp[2].start()
	elif chara == "Bob":
		value.get_child(3).value += 300
	elif chara == "Gem":
		value.get_child(2).value = value.get_child(2).max_value
	elif chara == "Pete":
		opp[0].get_child(2).value = 0
		opp[0].get_child(2).get_node("LagTime").start()
		
	triggerVoice(chara,false)
	value.get_child(6).get_node("Status").text = "Offline"
	value.get_child(6).get_node("Status").modulate = Color(255,0,0)





func timeout(chara,tur):
	if tur == "Pur":
		pass
	elif tur == "Yellow":
		chara.MaxAmmo = 35
		chara.Ammo = chara.MaxAmmo
		chara.get_child(0).text = "Ammo: " + str(chara.MaxAmmo)
	elif tur == "Bob":
		pass
	elif tur == "Gem":
		pass
	elif tur == "Pete":
		pass


func _on_PlayerTime_timeout():
	timeout(player,playerChar)


func _on_EnemyTime_timeout():
	timeout(enemy,enemyChar)
