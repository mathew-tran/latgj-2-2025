extends VBoxContainer

class_name EnemyHealthContainer

func RegisterEnemy(enemy : Enemy):
	var instance = load("res://Prefabs/HealthUI.tscn").instantiate()
	instance.RefHealthComponent = enemy.GetHealthComponent()
	instance.Name = enemy.Name
	add_child(instance)
