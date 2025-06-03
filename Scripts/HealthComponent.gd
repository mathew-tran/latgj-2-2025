extends Node

@export var MaxHealth = 10
var CurrentHealth = 3

signal OnTakeDamage(amount)
signal OnDeath

enum STATE {
	ALIVE,
	DEAD
}

var CurrentState = STATE.ALIVE

func _ready() -> void:
	Setup()
	
func Setup():
	CurrentHealth = MaxHealth	
	
func TakeDamage(amount):
	if CurrentState == STATE.DEAD:
		return
		
	OnTakeDamage.emit(amount)
	CurrentHealth -= amount
	
	if CurrentHealth <= 0:
		OnDeath.emit()
		CurrentState = STATE.DEAD
