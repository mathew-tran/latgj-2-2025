extends Label

func _ready() -> void:
	text = str(Persist.HiScore).pad_zeros(10)
	if Persist.bHasNewHighScore:
		modulate = Color.GREEN
	Persist.bHasNewHighScore = false
