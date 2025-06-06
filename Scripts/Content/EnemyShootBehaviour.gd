extends EnemyBehaviour

class_name ShootBehaviour

@export var AmountOfShots = 1
@export var FireRate = .2
@export var bLookAtPlayerWhileShooting = false

var CurrentAmount = 0
var bCanShoot = false

func GetName():
	return "SHOOT-BEHAVIOUR-" + str(AmountOfShots)
	
func Setup():
	CurrentAmount = 0
	bCanShoot = true
	print(bCanShoot)
	Finder.GetEnemy().modulate = Color.RED
	
func CanRun():
	return CurrentAmount < AmountOfShots

func Run(delta):
	if bLookAtPlayerWhileShooting:
		Finder.GetEnemy().look_at(Finder.GetPlayer().global_position)
	if bCanShoot:
		bCanShoot = false
		print(bCanShoot)
		await Finder.GetEnemy().Shoot(FireRate)
		CurrentAmount += 1
		bCanShoot = true
		print(bCanShoot)
		
		print(str(CurrentAmount) + "Shots made")

func Cleanup():
	bCanShoot = false
	Finder.GetEnemy().modulate = Color.WHITE
	
