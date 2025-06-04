extends Node2D

enum STATE {
	IDLE,
	SHOOTING
}
var CurrentState = STATE.IDLE

var BulletInstance = null
var StartPosition = Vector2.ZERO
var MidPosition = Vector2(50, 0)
var EndPosition = Vector2(75, 0)

func _ready() -> void:
	await get_tree().process_frame
	for x in range(0, 3):
		await Shoot(1)
		await Shoot(1)
		await Shoot(1)
	
func Shoot(speed = 1.0):
	if CurrentState == STATE.SHOOTING:
		return
		
	BulletInstance = load("res://Prefabs/Bullet.tscn").instantiate()
	BulletInstance.scale = Vector2.ZERO
	add_child(BulletInstance)
	var tween = get_tree().create_tween()
	tween.tween_property(BulletInstance, "scale", Vector2.ONE, .1)
	tween.tween_property(BulletInstance, "position", MidPosition, .3)
	await tween.finished
	await get_tree().create_timer(speed).timeout
	await get_tree().create_timer(.1).timeout
	
	if is_instance_valid(BulletInstance):
		BulletInstance.reparent(Finder.GetBulletGroup())
		BulletInstance.Shoot()
	
	
	
