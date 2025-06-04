extends Control

@export var Name = "Player"
@export var RefHealthComponent : HealthComponent

@export var bIsPlayer = false
func _ready() -> void:
	
	if bIsPlayer:
		RefHealthComponent = Finder.GetPlayer().GetHealthComponent()
		Name = "Player"
	RefHealthComponent.OnSetup.connect(OnSetup)
	RefHealthComponent.OnTakeDamage.connect(OnTakeDamage)
	RefHealthComponent.OnDeath.connect(OnDeath)
	
	$ProgressBar/Label.text = Name
	UpdateHealthBar()
	
func UpdateHealthBar():
	$ProgressBar.max_value = RefHealthComponent.MaxHealth
	$ProgressBar.value = RefHealthComponent.CurrentHealth
	
func OnSetup():
	UpdateHealthBar()
	
func OnTakeDamage(amount):
	UpdateHealthBar()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("hit")
	
func OnDeath():
	$ProgressBar/Label.text = "DEAD"
	UpdateHealthBar()
	$AnimationPlayer.stop()
	$AnimationPlayer.play("dead")
	if bIsPlayer == false:
		await $AnimationPlayer.animation_finished
		queue_free()
