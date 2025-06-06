extends EnemyBehaviour

class_name SpikeBehaviour

@export var bEnable = true

var bCanRun = false


func GetName():
	return "Spike-BEHAVIOUR-" + str(bEnable)
	
func Setup():
	bCanRun = true
	if bEnable:
		Finder.GetEnemy().modulate = Color.RED
		await Finder.GetEnemy().ActivateSpikes()
		Finder.GetEnemy().modulate = Color.WHITE
	else:
		await Finder.GetEnemy().DeactivateSpikes()
	bCanRun = false

func CanRun():
	return bCanRun

func Run(delta):
	pass

func Cleanup():
	bCanRun = true
	
