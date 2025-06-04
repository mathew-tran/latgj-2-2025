extends Node

@export var AttackPattern1 : Array[EnemyBehaviour]
var BehaviourIndex = 0

var CurrentPattern : Array[EnemyBehaviour]

var EnemyRef : Enemy

func _ready() -> void:
	EnemyRef = get_parent()
	CurrentPattern = AttackPattern1
	
func GetCurrentBehaviour() -> EnemyBehaviour:
	return CurrentPattern[BehaviourIndex]
	
func _process(delta: float) -> void:
	if GetCurrentBehaviour().CanRun():
		GetCurrentBehaviour().Run(delta)
	else:
		if len(CurrentPattern) - 1 > BehaviourIndex:
			GetNextBehaviour()
		else:
			GetNextPattern()
			
func GetNextBehaviour():
	GetCurrentBehaviour().Cleanup()
	BehaviourIndex += 1
	GetCurrentBehaviour().Setup()

func GetNextPattern():
	BehaviourIndex = 0
