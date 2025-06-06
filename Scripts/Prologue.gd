extends Panel

@export var PrologueData : Array[PrologueInfo]
@export var SongToPlay = SoundMixerManager.SONG_NAME.FIGHTYOUWANT
func _ready() -> void:
	ShowData()
	SoundMixer.PlaySong(SongToPlay)
	
func ShowData():
	if len(PrologueData) <= 0:
		GoToMain()
	else:
		var data = PrologueData.pop_front()
		$Sprite2D.texture = data.ContentImage
		$Text.visible_characters = 0
		$Text.text = ""
		$Text.text = data.TextContent
		var textLength = len($Text.text)
		var tween = get_tree().create_tween().tween_property($Text, "visible_characters", textLength, textLength * .05)
		await tween.finished
		await get_tree().create_timer(data.TimeToShow).timeout
		ShowData()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Punch"):
		GoToMain()

func GoToMain():
	get_tree().change_scene_to_file("res://Scene/Title.tscn")
	
