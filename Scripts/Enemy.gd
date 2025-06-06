extends CharacterBody2D

class_name Enemy

@export var Name = ""

var bIsActivated = false
var bCanMove = true
var MoveSpeed = 3000
var RunSpeed = 4500
var ExtremeSpeed = 6000

@export var NormalTexture : Texture2D
@export var HitTexture : Texture2D
@export var DeathTexture : Texture2D
@export var StillTexture : Texture2D
@export var FightMusic : SoundMixerManager.SONG_NAME
@export var KillXP = 500

signal OnDeath
func GetHealthComponent():
	return $HealthComponent
	
func _ready() -> void:
	await get_tree().process_frame
	bIsActivated = true
	Finder.GetEnemyHealthContainer().RegisterEnemy(self)
	
func ShowHitSprite():
	if $HealthComponent.IsAlive():
		$Sprite2D.texture = HitTexture

func ShowRegularSprite():
	if $HealthComponent.IsAlive():
		$Sprite2D.texture = NormalTexture
	
func Hit(damage, hitObject, knockback):
	if $HealthComponent.IsAlive() == false:
		return
	$HealthComponent.TakeDamage(damage)
	var direction = (global_position - hitObject.global_position).normalized()
	
	var modifier = 1
	var knockbackmodifier = 0
	if $HealthComponent.CurrentHealth <= 0:
		modifier *= 10
		knockbackmodifier = 500
		rotation_degrees += randf_range(0, 360)
	velocity += direction * (knockback + knockbackmodifier) * modifier
	
	if damage > 5:
		Finder.GetGame().Slomo(.2, .5)
	
	$HitAnim.play("hit")
	$CPUParticles2D.global_position = lerp(hitObject.global_position, global_position, .8)
	$CPUParticles2D.emitting = true
	Finder.GetGame().AddPoints(damage * 5)
	$HitParticle.emitting = true
	
	if knockback > 800:
		bCanMove = false
		$HitTimer.start()

func Shoot(speed):
	$Cannon.Shoot(speed)
	await $Cannon.ShotComplete
	
func _process(delta: float) -> void:
	if bIsActivated:
		velocity *= .75
		move_and_slide()		

func _on_health_component_on_death() -> void:
	$HitAnim.stop()
	$HitParticle.amount += 30
	$HitParticle.emitting = true
	await get_tree().create_timer(.1).timeout
	$Sprite2D.texture = DeathTexture
	await get_tree().create_timer(.3).timeout
	
	
	Finder.GetGame().AddPoints(KillXP)
	
	await get_tree().create_timer(.5).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, .3)
	
	await tween.finished
	OnDeath.emit()
	queue_free()

func ActivateSpikes():
	if get_node_or_null("SpikeHandLeft"):
		$SpikeHandLeft.EnableSpike()
	if get_node_or_null("SpikeHandRight"):
		$SpikeHandRight.EnableSpike()

func DeactivateSpikes():
	if get_node_or_null("SpikeHandLeft"):
		$SpikeHandLeft.DisableSpike()
	if get_node_or_null("SpikeHandRight"):
		$SpikeHandRight.DisableSpike()
	

func _on_timer_timeout() -> void:
	bCanMove = true
