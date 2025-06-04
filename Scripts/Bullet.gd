extends RigidBody2D
class_name Bullet

var Speed = 400

var bEnabled = false
var Velocity = Vector2.ZERO

func Shoot():
	bEnabled = true
	
func _process(delta: float) -> void:
	if bEnabled:
		global_position += transform.x * Speed * delta
