extends EnemyBehaviour

class_name WaitBehaviour

@export var Timeout = 1.0
var bHasTimedOut = false

@export var bLookAtPlayer = false

func GetName():
	return "WAIT-BEHAVIOUR-" + str(Timeout)
	
func Setup():
	await Finder.GetEnemy().get_tree().create_timer(Timeout).timeout
	bHasTimedOut = true
	print("timedout")
		
func CanRun():	
	return bHasTimedOut == false

func Run(delta):
	if bLookAtPlayer:
		Finder.GetEnemy().look_at(Finder.GetPlayer().global_position)

func Cleanup():
	bHasTimedOut = false
