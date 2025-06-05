extends EnemyBehaviour

class_name MoveBehaviour

@export var MovePosition : EnemyPositions.POSITIONS

enum MOVE_SPEED {
	SLOW,
	NORMAL,
	EXTREME
}
@export var MoveSpeed = MOVE_SPEED.NORMAL
@export var Timeout = -1.0
var bHasTimedOut = false
var PlannedPosition = Vector2.ZERO

func GetName():
	return "BEHAVIOUR-" + (EnemyPositions.POSITIONS.keys()[MovePosition])
	
func Setup():
	bHasTimedOut = false
	PlannedPosition = Finder.GetEnemyPositions().GetPosition(MovePosition)
	if Timeout > 0:
		await Finder.GetEnemy().get_tree().create_timer(Timeout).timeout
		bHasTimedOut = true
		print("timedout")
		
func CanRun():
	var enemy = Finder.GetEnemy()
	
	return enemy.global_position.distance_to(PlannedPosition) > 20 and bHasTimedOut == false

func Run(delta):
	var enemy = Finder.GetEnemy()
	var moveVector = (PlannedPosition - enemy.global_position).normalized()
	var speed = enemy.MoveSpeed
	match MoveSpeed:
		MOVE_SPEED.SLOW:
			speed = enemy.MoveSpeed
		MOVE_SPEED.NORMAL:
			speed = enemy.RunSpeed
		MOVE_SPEED.EXTREME:
			speed = enemy.ExtremeSpeed
	enemy.velocity += moveVector * speed * delta
	enemy.look_at(PlannedPosition)

func Cleanup():
	bHasTimedOut = false
