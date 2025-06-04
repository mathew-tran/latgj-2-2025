extends EnemyBehaviour

class_name ShootBehaviour

@export var AmountOfShots = 1
@export var FireRate = .2

var CurrentAmount = 0
var bCanShoot = false

func Setup():
	CurrentAmount = 0
	bCanShoot = true
	print(bCanShoot)
	
func CanRun():
	return CurrentAmount < AmountOfShots

func Run(delta):
	if bCanShoot:
		bCanShoot = false
		print(bCanShoot)
		await Finder.GetEnemy().Shoot(FireRate)
		bCanShoot = true
		print(bCanShoot)
		CurrentAmount += 1
		print(str(CurrentAmount) + "Shots made")
