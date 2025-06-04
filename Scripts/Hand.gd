extends Sprite2D

class_name Fist

signal Complete

var Damage = 0

enum ATTACK {
	JAB,
	STRAIGHT,
	BLOCK
}

var Knockback = 100
func Use(attack : ATTACK, speed = 1.0, damage = 2, knockback = 600):
	$AnimationPlayer.stop(true)
	Damage = damage
	Knockback = knockback
	$AnimationPlayer.speed_scale = speed
	
	match attack:
		ATTACK.JAB:	
			$AnimationPlayer.play("attack")
		ATTACK.STRAIGHT:
			$AnimationPlayer.play("straight")
		ATTACK.BLOCK:
			$AnimationPlayer.play("defend")
	await $AnimationPlayer.animation_finished
	
	Complete.emit()
	

func HitEnemies():
	var enemies = $Area2D.get_overlapping_areas()
	for enemy in enemies:
		if enemy.get_parent() is Player:
			break
		else:
			enemy.get_parent().Hit(Damage, self, Knockback)
			$hitAnim.stop()
			$hitAnim.play("hit")
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Bullet:
		if body.bEnabled:
			body.Hit()
