extends AnimatedSprite2D

signal Fired
signal Covered(value)
signal EnergyOut


@onready var spawn = get_node("PlayerBulletSpawn")
@onready var energybar = get_node("EnergyBar")
@onready var healthbar = get_node("HealthBar")
@onready var collide = get_node("StaticBody2D/CollisionShape2D")
var bullet = preload("res://Scenes/Bullet.tscn")
var Odamage = 5
var check = true
@export var MaxAmmo: int = 10
var Ammo = MaxAmmo
var isDown = false
var thing = false

func GetDown(value):
	if value:
		collide.disabled = true
		set("frame",0)
		isDown = true
		energybar.setBool(isDown)
	else:
		collide.disabled = false
		set("frame",1)
		isDown = false
		energybar.setBool(isDown)

func takeHit(damage):
	healthbar.value -= damage


func _input(event):
	if event.is_action_pressed("OnClick"):
		if Ammo > 0 && !isDown:
			Ammo -= 1
			get_node("ReloadWarning").text = "Ammo: " + str(Ammo)
			var ins = bullet.instantiate()
			ins.position = spawn.position
			ins.linear_velocity.x = 500
			ins.damage = Odamage
			add_child(ins)
			emit_signal("Fired")
		if Ammo == 0:
			Ammo -= 1
			get_node("ReloadTime").start()
			get_node("ReloadWarning").text = "*#!RELOADING!$*"
	if event.is_action_pressed("Space"):
		$"../AblityControl".triggerthing(self)
		thing = false
	if event.is_action_pressed("RightClick") && energybar.value > 0:
		GetDown(true)
		emit_signal("Covered",isDown)
	if event.is_action_released("RightClick"):
		GetDown(false)
		emit_signal("Covered",isDown)
		



func _on_ReloadTime_timeout():
	Ammo = MaxAmmo
	get_node("ReloadWarning").text = "Ammo: " + str(MaxAmmo)
	


func _on_EnergyBar_value_changed(value):
	if value <= 0:
		GetDown(false)
		emit_signal("EnergyOut")


func _on_HealthBar_value_changed(value):
	if value <= 0:
		$"../BackgroundNoise".stop()
		$"../TextureRect/RichTextLabel".text = "LOSS :,("
		$"../TextureRect/RichTextLabel".modulate = Color(255,0,0)
		$"../TextureRect/Button2".visible = false
		Gobal.level = 0
		$"../AnimationPlayer".play("DropDown")
		get_tree().paused = true
	if value <= healthbar.max_value/3:
		healthbar.modulate = Color(255,0,0)
	else:
		healthbar.modulate = Color(0,255,0)
	if value <= healthbar.max_value/2:
		if check:
			check = false
			thing = true
			get_node("Skill/Status").text = "Online"
			get_node("Skill/Status").modulate = Color(0,255,0)
			if !Gobal.mute:
				$"../VoiceLines".stream = load("res://Audio/BobReady.wav")
				$"../VoiceLines".play()
	
		
