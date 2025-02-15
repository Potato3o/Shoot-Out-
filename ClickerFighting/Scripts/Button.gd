extends Button

@export var path: String = ""
@export var cam: NodePath
@export var info: int = 0
@export var spec: bool = false
@export var spec2: bool = false

func _on_button_pressed():
	if spec2:
		get_tree().paused = false
		Gobal.level += 1
		get_tree().reload_current_scene()
		return
	if path != "":
		get_tree().paused = false
		Gobal.level = 0
		get_tree().change_scene_to_file(path)
	elif str(cam) != "":
		if spec:
			get_node(cam).get_node("Diff").visible = true
			get_node(cam).get_node("Character").visible = false
			get_node(cam).get_node("Fight").visible = false
		get_node(cam).current = true
	else:
		Gobal.diff = info
		get_parent().visible = false
		get_parent().get_parent().get_node("Character").visible = true


