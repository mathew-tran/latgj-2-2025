extends EnemyBehaviour

class_name SpikeBehaviour

@export var bEnable = true

var bCanRun = false


func GetName():
	return "Spike-BEHAVIOUR-" + str(bEnable)
	
func Setup():
	bCanRun = true
	if bEnable:
		await Finder.GetEnemy().ActivateSpikes()
	else:
		await Finder.GetEnemy().DeactivateSpikes()
	bCanRun = false

func CanRun():
	return bCanRun

func Run(delta):
	pass

func Cleanup():
	bCanRun = true
	
