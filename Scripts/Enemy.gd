extends CharacterBody2D


func _on_hitbox_area_entered(area: Area2D) -> void:
	$HealthComponent.TakeDamage(3)

func _on_health_component_on_death() -> void:
	queue_free()
