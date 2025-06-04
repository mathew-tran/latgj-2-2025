extends CharacterBody2D

class_name Player

var Speed = 1500

var CommandList = ""

enum STATE {
	IDLE,
	ATTACKING
}

var CurrentState = STATE.IDLE

var ComboMax = 6
signal OnComboStringChange(comboString)

func GetHealthComponent() -> HealthComponent:
	return $HealthComponent
	
func _ready() -> void:
	await get_tree().process_frame
	ClearCommand()
	
func SetAttacking():
	CurrentState = STATE.ATTACKING

func SetIdle():
	CurrentState = STATE.IDLE
	
func _process(delta: float) -> void:
	velocity *= .92
	move_and_slide()
	look_at(get_global_mouse_position())
	
	var moveVector = Vector2.ZERO
	
	if Input.is_action_pressed("Move_Left"):
		moveVector.x = -1
	if Input.is_action_pressed("Move_Right"):
		moveVector.x = 1
	
	if Input.is_action_pressed("Move_Up"):
		moveVector.y = -1
	if Input.is_action_pressed("Move_Down"):
		moveVector.y = 1
		
	velocity += moveVector * Speed * delta
	
	
	var bCommandAdded = false
	if IsAttacking() == false:
		if Input.is_action_just_released("Roll"):
			CommandList += "D"
			bCommandAdded = true	
		elif Input.is_action_just_released("Block"):
			CommandList += "B"	
			bCommandAdded = true
		elif Input.is_action_just_released("Left_Punch") and Input.is_action_just_released("Right_Punch"):
			CommandList += "L+R"
			bCommandAdded = true
		elif Input.is_action_just_released("Left_Punch"):
			CommandList += "L"
			bCommandAdded = true
		elif Input.is_action_just_released("Right_Punch"):
			CommandList += "R"
			bCommandAdded = true
	
	if bCommandAdded:
		OnComboStringChange.emit(CommandList)
		print(CommandList)
		ExecuteCommand()
		$Timer.start()
	
func IsAttacking():
	return CurrentState == STATE.ATTACKING
	
func UseLeft(attack = Fist.ATTACK.JAB, speed = 1, damage = 2, knockback = 100):
	SetAttacking()
	$LeftHand/Fist1.Use(attack, speed, damage, knockback)
	$Timer.paused = true
	$Timer.start()
	await $LeftHand/Fist1.Complete
	$Timer.paused = false
	
	
func UseRight(attack = Fist.ATTACK.JAB, speed = 1, damage = 2, knockback = 100):
	SetAttacking()
	$Timer.paused = true
	$Timer.start()
	
	$RightHand/Fist2.Use(attack, speed, damage, knockback)
	await $RightHand/Fist2.Complete
	$Timer.paused = false
	
func ExecuteCommand():
	if IsAttacking():
		return
		
	if CommandList == "L+R":
		UseLeft()
		await UseRight()
		SetIdle()		
	elif CommandList == "DL":
		velocity -= Vector2.RIGHT.rotated(rotation) * 1000
		UseRight(Fist.ATTACK.STRAIGHT)
		await UseLeft(Fist.ATTACK.STRAIGHT)
		UseRight(Fist.ATTACK.STRAIGHT, 2)
		await UseLeft(Fist.ATTACK.STRAIGHT, 2)
		SetIdle()
	elif CommandList == "DR":
		await UseRight(Fist.ATTACK.STRAIGHT, 5)
		await UseLeft(Fist.ATTACK.STRAIGHT, 5)
		await UseRight(Fist.ATTACK.JAB, 3)
		await UseLeft(Fist.ATTACK.JAB, 3)
		await UseRight(Fist.ATTACK.STRAIGHT, 2)
		await UseLeft(Fist.ATTACK.JAB, 2)
		SetIdle()
	elif CommandList == "LLL":
		await UseLeft(Fist.ATTACK.JAB, 2)
		await UseLeft(Fist.ATTACK.STRAIGHT, 2)
		await UseLeft(Fist.ATTACK.JAB, 2)
		SetIdle()
	elif CommandList == "LLLLLL":
		await UseLeft(Fist.ATTACK.JAB, 2)
		await UseLeft(Fist.ATTACK.JAB, 4)
		await UseLeft(Fist.ATTACK.JAB, 6)
		await UseLeft(Fist.ATTACK.JAB, 8)
		await UseLeft(Fist.ATTACK.JAB, 10)
		SetIdle()
	elif CommandList == "RRR":
		await UseRight(Fist.ATTACK.STRAIGHT, 2)
		await UseRight(Fist.ATTACK.STRAIGHT, 3)
		velocity += Vector2.RIGHT.rotated(rotation) * 1500
		await UseRight(Fist.ATTACK.STRAIGHT, 1, 4)
		SetIdle()
	elif CommandList == "LLR":
		velocity += Vector2.RIGHT.rotated(rotation) * 1500
		await UseRight(Fist.ATTACK.STRAIGHT, 2, 12, 4000)
		SetIdle()		
	elif CommandList == "LLRL":
		await UseLeft(Fist.ATTACK.JAB, 3, 1)
		await UseRight(Fist.ATTACK.JAB, 3, 1)
		SetIdle()
	elif CommandList == "LRLRLR":
		await UseLeft(Fist.ATTACK.JAB, 3, 1)
		await UseRight(Fist.ATTACK.JAB, 3, 1)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + 360, .2)
		await tween.finished
		await UseLeft(Fist.ATTACK.JAB, 5, 1)
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.JAB, 5, 1)
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.JAB, 5, 1)
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.JAB, 5, 1)
		SetIdle()
	elif CommandList == "LLLLLR":
		await UseLeft(Fist.ATTACK.STRAIGHT, 1, 1)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.STRAIGHT, 1, 1)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.STRAIGHT, 1, 1)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.STRAIGHT, 1, 1)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		await UseLeft(Fist.ATTACK.STRAIGHT, 1, 1)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseRight(Fist.ATTACK.JAB, 5, 1)
		SetIdle()
	elif CommandList == "LLRRB":
		await UseLeft(Fist.ATTACK.JAB, 5, 1, 800)
		UseRight(Fist.ATTACK.JAB, 5, 1, 800)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseLeft(Fist.ATTACK.JAB, 5, 1, 800)
		UseRight(Fist.ATTACK.JAB, 5, 1, 800)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await UseLeft(Fist.ATTACK.JAB, 5, 1, 800)
		UseRight(Fist.ATTACK.JAB, 5, 1, 800)
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		SetIdle()
	elif CommandList == "BLLL":
		for x in range(0, 3):
			velocity += Vector2.RIGHT.rotated(rotation) * 800
			await UseLeft(Fist.ATTACK.JAB, 2)
			await UseRight(Fist.ATTACK.JAB, 2)
		SetIdle()
	elif CommandList == "LLL+R":
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", rotation_degrees + 360, .5)
		for x in range(0, 3):
			await UseLeft()
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		await get_tree().create_timer(.1).timeout
		UseLeft()
		await UseRight()
		SetIdle()
	elif CommandList == "L+RLR":
		var bEven = false
		for x in range(0, 12):
			velocity += Vector2.RIGHT.rotated(rotation) * 300
			if bEven:
				await UseLeft(Fist.ATTACK.JAB, 3, 1)
			else:
				await UseRight(Fist.ATTACK.JAB, 3, 1)
			bEven = !bEven
			
		await get_tree().create_timer(.1).timeout
		velocity += Vector2.RIGHT.rotated(rotation) * 800
		UseLeft()
		await UseRight()
		SetIdle()
	elif CommandList == "BR":
		velocity += Vector2.RIGHT.rotated(rotation) * 100
		await UseRight(Fist.ATTACK.STRAIGHT, 2, 3, 2000)
		SetIdle()
	elif CommandList == "BL":
		velocity += Vector2.RIGHT.rotated(rotation) * 100
		await UseLeft(Fist.ATTACK.STRAIGHT, 2, 3, 2000)
		SetIdle()
	elif CommandList.ends_with("BBB"):
		velocity -= Vector2.RIGHT.rotated(rotation) * 1500
		UseRight(Fist.ATTACK.BLOCK)
		await UseLeft(Fist.ATTACK.BLOCK)
		SetIdle()
	elif CommandList.ends_with("BB"):
		velocity -= Vector2.RIGHT.rotated(rotation) * 1000
		UseRight(Fist.ATTACK.BLOCK)
		await UseLeft(Fist.ATTACK.BLOCK)
		SetIdle()
	elif CommandList.ends_with("DB"):
		velocity -= Vector2.RIGHT.rotated(rotation) * 1500
		UseRight(Fist.ATTACK.BLOCK)
		await UseLeft(Fist.ATTACK.BLOCK)
		SetIdle()
	elif CommandList.ends_with("BD"):
		velocity += Vector2.RIGHT.rotated(rotation) * 1500
		UseRight(Fist.ATTACK.BLOCK)
		await UseLeft(Fist.ATTACK.BLOCK)
		SetIdle()
	elif CommandList.ends_with("R"):
		await UseRight()
		SetIdle()
	elif CommandList.ends_with("L"):
		await UseLeft()
		SetIdle()
	elif CommandList.ends_with("B"):
		UseRight(Fist.ATTACK.BLOCK)
		await UseLeft(Fist.ATTACK.BLOCK)
		SetIdle()
	elif CommandList.ends_with("DD"):
		velocity += Vector2.RIGHT.rotated(rotation) * 2000
		SetAttacking()
		await get_tree().create_timer(.4).timeout
		SetIdle()
		ClearCommand()
	elif CommandList.ends_with("D"):
		velocity += Vector2.RIGHT.rotated(rotation) * 1000
		await get_tree().create_timer(.4).timeout
		SetAttacking()
		SetIdle()
	if CommandList.length() >= ComboMax:
		ClearCommand()
	
func ClearCommand():
	CommandList = ""
	$ResetParticle.emitting = true
	OnComboStringChange.emit(CommandList)
	
func _on_timer_timeout() -> void:
	ClearCommand()
	


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body is Bullet:
		if body.bEnabled == false:
			return
	$HealthComponent.TakeDamage(3)
	
	if body is Bullet:
		body.queue_free()
