extends CharacterBody2D

func Hit(damage, hitObject, knockback):
	$HealthComponent.TakeDamage(damage)
	var direction = (global_position - hitObject.global_position).normalized()
	velocity += direction * knockback
	$HitAnim.play("hit")

func _process(delta: float) -> void:
	velocity *= .75
	move_and_slide()

func _on_health_component_on_death() -> void:
	queue_free()
