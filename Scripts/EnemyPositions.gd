extends Node2D

class_name EnemyPositions

enum POSITIONS {
	MIDDLE,
	LEFT
}

func GetPosition(pos : POSITIONS):
	match pos:
		POSITIONS.MIDDLE:
			return $Middle.global_position
		POSITIONS.LEFT:
			return $Left.global_position
