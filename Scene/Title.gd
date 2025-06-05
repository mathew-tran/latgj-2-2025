extends CanvasLayer

func _ready() -> void:
	$AnimationPlayer.play("anim")
	
func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Scene/Main.tscn")


func _on_bert_button_button_up() -> void:
	OS.shell_open("https://www.bitbybitsound.com")
