extends EnemyBehaviour

class_name MoveBehaviour

@export var MovePosition : EnemyPositions.POSITIONS
@export var bIsRunning = false

func CanRun():
	var enemy = Finder.GetEnemy()
	var position = Finder.GetEnemyPositions().GetPosition(MovePosition)
	
	return enemy.global_position.distance_to(position) > 20

func Run(delta):
	var enemy = Finder.GetEnemy()
	var position = Finder.GetEnemyPositions().GetPosition(MovePosition)
	var moveVector = (position - enemy.global_position).normalized()
	var speed = enemy.MoveSpeed
	if bIsRunning:
		speed = enemy.RunSpeed
	enemy.velocity += moveVector * speed * delta
	enemy.look_at(position)
