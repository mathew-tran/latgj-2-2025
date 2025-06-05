extends Node2D

class_name Game

var Points = 0

signal OnPointsAdded(amount)
signal OnPlayerDied

enum STATE {
	VERSUS_SCREEN,
	GAMEPLAY
}

var CurrentState = STATE.VERSUS_SCREEN

var Enemies = [
	"res://Prefabs/Enemies/Toasty.tscn",
	"res://Prefabs/Enemies/Toasty.tscn",
	"res://Prefabs/Enemies/Toasty.tscn",
]
func CanPlay():
	return CurrentState == STATE.GAMEPLAY
	
	
func SpawnEnemy():
	CurrentState = STATE.VERSUS_SCREEN
	$CanvasLayer/BeginBlocker.visible = true
	SoundMixer.PlaySong(SoundMixerManager.SONG_NAME.BATTLEWITHBEASTS)
	var newEnemy = load(Enemies.pop_front()).instantiate()
	
	newEnemy.global_position = $SpawnPoints.get_children().pick_random().global_position
	$Enemies.add_child(newEnemy)
	var instance = load("res://Scene/VersusScreen.tscn").instantiate()
	add_child(instance)
	await instance.MidAnimationComplete
	$CanvasLayer/BeginBlocker.visible = false
	await instance.CompleteAnimation
	CurrentState = STATE.GAMEPLAY
	newEnemy.OnDeath.connect(OnEnemyDeath)
	
func OnEnemyDeath():
	if len(Enemies) > 0:
		SpawnEnemy()
	else:
		# Show victory screen
		pass
	
func _ready() -> void:
	$CanvasLayer/BeginBlocker.visible = true
	await get_tree().process_frame
	GetPlayer().GetHealthComponent().OnDeath.connect(OnPlayerDeath)
	SpawnEnemy()
	
	
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
