extends CheckBox


func _ready():
	set("pressed",Gobal.mute)


func _on_CheckBox_toggled(button_pressed):
	Gobal.mute = button_pressed
