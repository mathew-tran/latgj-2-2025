extends EnemyBehaviour

class_name RotateBehaviour

@export var RotateDegrees = 360
@export var RotateTime = 1.0

var bCanRun = false

func GetName():
	return "ROTATE-BEHAVIOUR-" + str(RotateDegrees)
	
func Setup():
	bCanRun = true
	Finder.GetEnemy().modulate = Color.RED
	var tween = Finder.GetEnemy().create_tween()
	tween.tween_property(Finder.GetEnemy(), "rotation_degrees", Finder.GetEnemy().rotation_degrees + RotateDegrees, RotateTime)
	await tween.finished
	Finder.GetEnemy().modulate = Color.WHITE
	
	bCanRun = false

func CanRun():
	return bCanRun

func Run(delta):
	pass

func Cleanup():
	bCanRun = true
	
