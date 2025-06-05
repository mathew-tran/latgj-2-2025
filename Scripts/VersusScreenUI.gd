extends Node2D

signal MidAnimationComplete
signal CompleteAnimation

func _ready() -> void:
	await get_tree().create_timer(.2).timeout
	var enemy = Finder.GetEnemy()
	$CanvasLayer/Panel2/NamePlate/Label.text = enemy.Name.to_upper()
	
	$CanvasLayer/Panel2/Player.texture = enemy.StillTexture
	$CanvasLayer/AnimationPlayer.play("anim")
	SoundMixer.PlaySong(enemy.FightMusic)
	await $CanvasLayer/AnimationPlayer.animation_finished
	MidAnimationComplete.emit()
	$CanvasLayer/AnimationPlayer.speed_scale *= 2
	$CanvasLayer/AnimationPlayer.play_backwards("end")
	await $CanvasLayer/AnimationPlayer.animation_finished
	CompleteAnimation.emit()
	queue_free()
