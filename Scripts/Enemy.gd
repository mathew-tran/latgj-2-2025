extends CharacterBody2D

func Hit(damage, hitObject, knockback):
	$HealthComponent.TakeDamage(damage)
	var direction = (global_position - hitObject.global_position).normalized()
	velocity += direction * knockback
	$HitAnim.play("hit")
	$CPUParticles2D.global_position = lerp(hitObject.global_position, global_position, .8)
	$CPUParticles2D.emitting = true

func _process(delta: float) -> void:
	velocity *= .75
	move_and_slide()

func _on_health_component_on_death() -> void:
	await get_tree().create_timer(.1).timeout
	queue_free()
