extends Node

class_name HealthComponent

@export var MaxHealth = 10
var CurrentHealth = 3

signal OnTakeDamage(amount)
signal OnDeath
signal OnSetup

enum STATE {
	ALIVE,
	DEAD
}

var CurrentState = STATE.ALIVE

func _ready() -> void:
	Setup()
	
func Setup():
	CurrentHealth = MaxHealth	
	CurrentState = STATE.ALIVE
	
	await get_tree().process_frame
	OnSetup.emit()
	
func Recover():
	
	await get_tree().create_timer(.1).timeout
	var healthToIncrease = round(MaxHealth * .30)
	while healthToIncrease > 0:
		CurrentHealth += 1
		healthToIncrease -= 1
		
		if CurrentHealth > MaxHealth:
			CurrentHealth = MaxHealth
			Finder.GetGame().AddPoints(healthToIncrease * 200)
			break
		OnTakeDamage.emit(0)
		await get_tree().create_timer(.1).timeout
	
	
func TakeDamage(amount):
	if CurrentState == STATE.DEAD:
		return
		

	CurrentHealth -= amount
	OnTakeDamage.emit(amount)
	
	if CurrentHealth <= 0:
		OnDeath.emit()
		CurrentState = STATE.DEAD
	
func IsAlive():
	return CurrentState == STATE.ALIVE
