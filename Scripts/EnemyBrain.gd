extends Node

@export var EntryPattern : Array[EnemyBehaviour]
@export var AttackPattern1 : Array[EnemyBehaviour]
@export var AttackPattern2 : Array[EnemyBehaviour]
@export var AttackPattern3 : Array[EnemyBehaviour]

var BehaviourIndex = 0
var PatternIndex = 0

var CurrentPattern : Array[EnemyBehaviour]

var EnemyRef : Enemy

func _ready() -> void:
	EnemyRef = get_parent()
	ChoosePattern()
	CurrentPattern = EntryPattern
	
func GetCurrentBehaviour() -> EnemyBehaviour:
	return CurrentPattern[BehaviourIndex]
	
func _process(delta: float) -> void:
	if Finder.GetGame().CanPlay() == false:
		return
	if EnemyRef.GetHealthComponent().IsAlive() == false:
		return
	if EnemyRef.bCanMove == false:
		return
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
	print("Start Behaviour: " + GetCurrentBehaviour().GetName())

func GetPatterns(index):
	match index:
		0:
			return AttackPattern1
		1:
			return AttackPattern2
		2:
			return AttackPattern3
	
func ChoosePattern():
	var possiblePatterns = []
	if PatternIndex != 0:
		possiblePatterns.append(0)
	if PatternIndex != 1:
		possiblePatterns.append(1)
	if PatternIndex != 2:
		possiblePatterns.append(2)
	PatternIndex = possiblePatterns.pick_random()
	CurrentPattern = GetPatterns(PatternIndex)
	BehaviourIndex = 0
	GetCurrentBehaviour().Setup()
			
func GetNextPattern():	
	GetCurrentBehaviour().Cleanup()
	
	ChoosePattern()
	
	
	print("New Pattern")
