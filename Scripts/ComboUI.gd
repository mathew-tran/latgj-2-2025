extends Label

func _init() -> void:
	text = ""
func _ready() -> void:
	Finder.GetPlayer().OnComboStringChange.connect(OnComboStringChanged)
	
func OnComboStringChanged(comboString):
	text = comboString
	while len(text) < Finder.GetPlayer().ComboMax:
		text += "-"
	
