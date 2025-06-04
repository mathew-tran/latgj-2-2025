extends Node

func GetPlayer() -> Player:
	var result = get_tree().get_nodes_in_group("Player")
	return get_tree().get_nodes_in_group("Player")[0]
	
func GetBulletGroup():
	return get_tree().get_nodes_in_group("Bullets")[0]
	
func GetEnemyHealthContainer() -> EnemyHealthContainer:
	return get_tree().get_nodes_in_group("EnemyHealthContainer")[0]
