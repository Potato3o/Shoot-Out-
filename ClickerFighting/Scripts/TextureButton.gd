extends TextureButton


@export var character: String = ""


func _on_TextureButton_pressed():
	if character != "":
		Gobal.character = character
		get_parent().visible = false
		get_parent().get_parent().get_node("Fight").visible = true
