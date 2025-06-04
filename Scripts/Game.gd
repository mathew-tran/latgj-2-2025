extends Node2D

class_name Game

var Points = 0

signal OnPointsAdded(amount)
signal OnPlayerDied

func _ready() -> void:
	await get_tree().process_frame
	GetPlayer().GetHealthComponent().OnDeath.connect(OnPlayerDeath)
	
func OnPlayerDeath():
	OnPlayerDied.emit()
	
func GetPlayer():
	return Finder.GetPlayer()

func GetEnemy():
	return Finder.GetEnemy()

func AddPoints(amount):
	Points += amount
	OnPointsAdded.emit(Points)

func Slomo(time, amount):
	Engine.time_scale = amount
	await get_tree().create_timer(time).timeout
	Engine.time_scale = 1
