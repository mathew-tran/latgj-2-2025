extends RigidBody2D
class_name Bullet

var Speed = 800

var bEnabled = false
var Velocity = Vector2.ZERO

var bHasHit = false

func Shoot():
	bEnabled = true
	$Timer.start()
	
func _process(delta: float) -> void:
	if bEnabled:
		global_position += transform.x * Speed * delta


func Hit():
	if bHasHit:
		return
	rotation_degrees += randf_range(0, 360)
	$CollisionShape2D.queue_free()
	$Timer.wait_time = .1
	$Timer.start()
	bHasHit = true
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, .1)
func _on_timer_timeout() -> void:
	queue_free()
