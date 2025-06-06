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
	
	$ProgressBar/Label.text = Name.to_upper()
	UpdateHealthBar()
	
func UpdateHealthBar():
	$ProgressBar.max_value = RefHealthComponent.MaxHealth
	$ProgressBar.value = RefHealthComponent.CurrentHealth
	
func OnSetup():
	UpdateHealthBar()
	
func OnTakeDamage(amount):
	UpdateHealthBar()
	if amount > 0:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("hit")
	
func OnDeath():
	$ProgressBar/Label.text = "DEAD"
	UpdateHealthBar()

	if bIsPlayer == false:
		$AnimationPlayer.stop()
		$AnimationPlayer.play("dead")
		await $AnimationPlayer.animation_finished
		queue_free()
