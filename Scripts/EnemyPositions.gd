extends Node2D

class_name EnemyPositions

enum POSITIONS {
	LEFT,
	RIGHT,
	MIDDLE,
	BOTTOM_LEFT,
	BOTTOM_RIGHT,
	BOTTOM_MIDDLE,
	TOP_LEFT,
	TOP_RIGHT,
	TOP_MIDDLE,
	PLAYER
}

func _init() -> void:
	visible = false
	
func GetPosition(pos : POSITIONS):
	match pos:
		POSITIONS.MIDDLE:
			return $Middle.global_position
		POSITIONS.LEFT:
			return $Left.global_position
		POSITIONS.RIGHT:
			return $Right.global_position
		POSITIONS.BOTTOM_LEFT:
			return $BottomLeft.global_position
		POSITIONS.BOTTOM_MIDDLE:
			return $BottomMiddle.global_position
		POSITIONS.BOTTOM_RIGHT:
			return $BottomRight.global_position
		POSITIONS.TOP_LEFT:
			return $TopLeft.global_position
		POSITIONS.TOP_MIDDLE:
			return $TopMiddle.global_position
		POSITIONS.TOP_RIGHT:
			return $TopRight.global_position
		POSITIONS.PLAYER:
			return Finder.GetPlayer().global_position
