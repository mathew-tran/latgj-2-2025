extends CharacterBody2D

class_name Enemy

@export var Name = ""

var bIsActivated = false

var MoveSpeed = 1600
var RunSpeed = 4800

@export var NormalTexture : Texture2D
@export var HitTexture : Texture2D

func GetHealthComponent():
	return $HealthComponent
	
func _ready() -> void:
	await get_tree().process_frame
	bIsActivated = true
	Finder.GetEnemyHealthContainer().RegisterEnemy(self)
	
func ShowHitSprite():
	$Sprite2D.texture = HitTexture

func ShowRegularSprite():
	$Sprite2D.texture = NormalTexture
	
func Hit(damage, hitObject, knockback):
	$HealthComponent.TakeDamage(damage)
	var direction = (global_position - hitObject.global_position).normalized()
	velocity += direction * knockback
	
	$HitAnim.play("hit")
	$CPUParticles2D.global_position = lerp(hitObject.global_position, global_position, .8)
	$CPUParticles2D.emitting = true

func Shoot(speed):
	$Cannon.Shoot(speed)
	await $Cannon.ShotComplete
	
func _process(delta: float) -> void:
	if bIsActivated:
		velocity *= .75
		move_and_slide()		

func _on_health_component_on_death() -> void:
	await get_tree().create_timer(.1).timeout
	queue_free()
