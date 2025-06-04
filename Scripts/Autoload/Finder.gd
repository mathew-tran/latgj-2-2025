extends Node

func GetPlayer() -> Player:
	return get_tree().get_nodes_in_group("Player")[0]

func GetEnemy() -> Enemy:
	return get_tree().get_nodes_in_group("Enemy")[0]
		
func GetBulletGroup():
	return get_tree().get_nodes_in_group("Bullets")[0]
	
func GetEnemyHealthContainer() -> EnemyHealthContainer:
	return get_tree().get_nodes_in_group("EnemyHealthContainer")[0]

func GetEnemyPositions() -> EnemyPositions:
	return get_tree().get_nodes_in_group("EnemyPositions")[0]

func GetGame() -> Game:
	return get_tree().get_nodes_in_group("Game")[0]
