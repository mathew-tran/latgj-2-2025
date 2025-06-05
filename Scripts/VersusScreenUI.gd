extends Node2D

signal MidAnimationComplete
signal CompleteAnimation

func _ready() -> void:
	var enemy = Finder.GetEnemy()
	$CanvasLayer/Panel2/NamePlate/Label.text = enemy.Name.to_upper()
	$CanvasLayer/Panel2/Player.texture = enemy.NormalTexture
	$CanvasLayer/AnimationPlayer.play("anim")
	await $CanvasLayer/AnimationPlayer.animation_finished
	MidAnimationComplete.emit()
	$CanvasLayer/AnimationPlayer.speed_scale *= 2
	$CanvasLayer/AnimationPlayer.play_backwards("end")
	await $CanvasLayer/AnimationPlayer.animation_finished
	CompleteAnimation.emit()
	queue_free()
