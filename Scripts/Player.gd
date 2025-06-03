extends CharacterBody2D

class_name Player

var Speed = 1500

var CommandList = ""

enum STATE {
	IDLE,
	ATTACKING
}

var CurrentState = STATE.IDLE

func SetAttacking():
	CurrentState = STATE.ATTACKING

func SetIdle():
	CurrentState = STATE.IDLE
	
func _process(delta: float) -> void:
	velocity *= .88
	move_and_slide()
	if IsAttacking():
		return
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
		if Input.is_action_just_released("Left_Punch") and Input.is_action_just_released("Right_Punch"):
			CommandList += "L+R"
			bCommandAdded = true
		elif Input.is_action_just_released("Left_Punch"):
			CommandList += "L"
			bCommandAdded = true
		elif Input.is_action_just_released("Right_Punch"):
			CommandList += "R"
			bCommandAdded = true
	
	if bCommandAdded:
		print(CommandList)
		ExecuteCommand()
		$Timer.start()
	
func IsAttacking():
	return CurrentState == STATE.ATTACKING
	
func UseLeft(attack = Fist.ATTACK.JAB, speed = 1, damage = 2, knockback = 100):
	SetAttacking()
	$LeftHand/Fist1.Use(attack, speed, damage, knockback)
	await $LeftHand/Fist1.Complete
	
func UseRight(attack = Fist.ATTACK.JAB, speed = 1, damage = 2, knockback = 100):
	SetAttacking()
	$RightHand/Fist2.Use(attack, speed, damage, knockback)
	await $RightHand/Fist2.Complete
	
func ExecuteCommand():
	if IsAttacking():
		return
		
	if CommandList == "L+R":
		UseLeft()
		await UseRight()
		SetIdle()		
		
	elif CommandList == "LLR":
		velocity += Vector2.RIGHT.rotated(rotation) * 1500
		await UseRight(Fist.ATTACK.STRAIGHT, 2, 5, 4000)
		SetIdle()		
	elif CommandList == "LLRL":
		await UseLeft(Fist.ATTACK.JAB, 3, 1)
		await UseRight(Fist.ATTACK.JAB, 3, 1)
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
		
	elif CommandList.ends_with("R"):
		await UseRight()
		SetIdle()
	elif CommandList.ends_with("L"):
		await UseLeft()
		SetIdle()
	
	if CommandList.length() > 10:
		ClearCommand()

func ClearCommand():
	CommandList = ""
	
func _on_timer_timeout() -> void:
	ClearCommand()
