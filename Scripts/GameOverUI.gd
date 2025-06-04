extends Panel

func _ready() -> void:
	Finder.GetGame().OnPlayerDied.connect(OnPlayerDied)
	
func OnPlayerDied():
	$AnimationPlayer.play("anim")


func _on_restart_button_button_up() -> void:
	get_tree().reload_current_scene()
