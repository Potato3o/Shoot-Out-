extends RigidBody2D

@export var damage: int = 5



func _on_RigidBody2D_body_entered(body):
	var par = body.get_parent()
	if par != get_parent():
		par.takeHit(damage)
	queue_free()
