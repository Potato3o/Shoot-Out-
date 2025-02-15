extends TextureProgressBar


var isDown = false
var shouldCharge = true

func _process(delta):
	if isDown && !shouldCharge:
		self.value -= 1
	if !isDown && shouldCharge:
		self.value += 1.5

func setBool(value):
	if value:
		isDown = true
		shouldCharge = false
	elif !value && !shouldCharge:
		get_node("LagTime").start()
		shouldCharge = true



func _on_LagTime_timeout():
	if shouldCharge:
		isDown = false
