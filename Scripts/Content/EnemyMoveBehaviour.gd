extends EnemyBehaviour

class_name MoveBehaviour

@export var MovePosition : EnemyPositions.POSITIONS
@export var bIsRunning = false
@export var Timeout = -1.0
var bHasTimedOut = false

func GetName():
	return "BEHAVIOUR-" + (EnemyPositions.POSITIONS.keys()[MovePosition])
	
func Setup():
	bHasTimedOut = false
	if Timeout > 0:
		await Finder.GetEnemy().get_tree().create_timer(Timeout).timeout
		bHasTimedOut = true
		print("timedout")
		
func CanRun():
	var enemy = Finder.GetEnemy()
	var position = Finder.GetEnemyPositions().GetPosition(MovePosition)
	
	return enemy.global_position.distance_to(position) > 20 and bHasTimedOut == false

func Run(delta):
	var enemy = Finder.GetEnemy()
	var position = Finder.GetEnemyPositions().GetPosition(MovePosition)
	var moveVector = (position - enemy.global_position).normalized()
	var speed = enemy.MoveSpeed
	if bIsRunning:
		speed = enemy.RunSpeed
	enemy.velocity += moveVector * speed * delta
	enemy.look_at(position)

func Cleanup():
	bHasTimedOut = false
