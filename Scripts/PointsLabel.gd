extends Label

func _ready() -> void:
	Finder.GetGame().OnPointsAdded.connect(OnPointsAdded)
	OnPointsAdded(0)
	
func OnPointsAdded(amount):
	text = str(amount).pad_zeros(10)
	
