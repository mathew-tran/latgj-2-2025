extends Sprite2D

class_name SpikeHand

func _ready() -> void:
	DisableSpike()

func EnableSpike():
	$Spike/CollisionShape2D.disabled = false
	$Spike/AnimationPlayer.play("retract")
	await $Spike/AnimationPlayer.animation_finished
	$Spike/AnimationPlayer.play("anim")

func DisableSpike():
	$Spike/CollisionShape2D.disabled = true
	$Spike/AnimationPlayer.play_backwards("retract")
	await $Spike/AnimationPlayer.animation_finished
	
func _on_spike_body_entered(body: Node2D) -> void:
	if body is Player:
		body.GetHit(self, 2)
