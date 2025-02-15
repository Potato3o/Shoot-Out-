extends AnimatedSprite2D


func showstuff(value):
	if value:
		set("frame",1)
		get_parent().get_node("Pilot").visible = true
		get_parent().get_node("Stats").visible = false
	elif !value:
		set("frame",0)
		get_parent().get_node("Pilot").visible = false
		get_parent().get_node("Stats").visible = true




func _on_Area2D_mouse_entered():
	print("mouse enter")
	showstuff(true)


func _on_Area2D_mouse_exited():
	showstuff(false)
