extends Sprite2D

func Use():
	if $AnimationPlayer.is_playing():
		return
	$AnimationPlayer.play("attack")
