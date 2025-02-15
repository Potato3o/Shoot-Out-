extends AnimatedSprite2D

var diff = Gobal.diff + 1
@export var FireRate: int = 25
@onready var collide = get_node("StaticBody2D2/CollisionShape2D")
@onready var healthbar = get_node("HealthBar2")
@onready var energybar = get_node("EnergyBar2")
@onready var spawn = get_node("EnemyBulletSpawn")
var bullet = preload("res://Scenes/EnemyBullet.tscn")
var isDoing = false
var Odamage = 5
var thing = true
@export var MaxAmmo: int = 10
var Ammo = MaxAmmo


func _ready():
	healthbar.max_value += 75 * (diff-1)
	healthbar.value = healthbar.max_value

func GetDown(value):
	if value:
		collide.disabled = true
		set("frame",0)
		isDoing = true
		energybar.setBool(true)
	else:
		collide.disabled = false
		set("frame",1)
		isDoing = false
		energybar.setBool(false)

func takeHit(damage):
	healthbar.value -= damage

func randomInt(x):
	randomize()
	if x < 1:
		return 0
	return randi()%x

func TakeTheShot():
	if Ammo > 0 && !isDoing:
		Ammo -= 1
		get_node("ReloadWarning2").text = "Ammo: " + str(Ammo)
		var ins = bullet.instantiate()
		ins.position = spawn.position
		ins.linear_velocity.x = -500
		ins.damage = Odamage * clamp(diff,1,2.5)
		add_child(ins)
	if Ammo == 0:
		Ammo -= 1
		get_node("ReloadTime2").start()
		get_node("ReloadWarning2").text = "*#!RELOADING!$*"
		if randomInt(2/diff) == 0 && energybar.value > 0:
			GetDown(true)

func _process(delta):
	if !isDoing && randomInt(FireRate/diff) == 0:
		TakeTheShot()
	if !isDoing:
		set("frame",1)
		collide.disabled = false



func _on_HealthBar2_value_changed(value):
	if value <= 0:
		$"../BackgroundNoise".stop()
		$"../AnimationPlayer".play("DropDown")
		get_tree().paused = true
	if value <= healthbar.max_value/3:
		healthbar.modulate = Color(0,255,0)
	else:
		healthbar.modulate = Color(255,0,0)
	if value <= healthbar.max_value/2:
		$"../AblityControl".triggerthing(self)
		thing = false


func _on_PlayerTurret_Covered(value):
	if value && randomInt(2/diff) == 0:
		if isDoing:
			GetDown(false)
		isDoing = true
	else:
		isDoing = false


func _on_PlayerTurret_EnergyOut():
	if randomInt(3/diff) == 0:
		for _i in range(3):
			TakeTheShot()


func _on_PlayerTurret_Fired():
	if randomInt(5/diff) == 0 && energybar.value > 0:
		GetDown(true)
		get_node("WaitTime").start()


func _on_ReloadTime2_timeout():
	Ammo = MaxAmmo
	get_node("ReloadWarning2").text = "Ammo: " + str(MaxAmmo)


func _on_EnergyBar2_value_changed(value):
	if value <= 0:
		GetDown(false)


func _on_WaitTime_timeout():
	GetDown(false)
