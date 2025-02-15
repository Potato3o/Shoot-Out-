extends AnimationPlayer


@export var anime: String = "Thanks"


func _ready():
	if Gobal.diff == 2:
		anime = "TrueThanks"
	self.play(anime)
