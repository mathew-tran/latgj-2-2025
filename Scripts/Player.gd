extends CharacterBody2D

var Speed = 1500


func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	var moveVector = Vector2.ZERO
	velocity *= .88
	if Input.is_action_pressed("Move_Left"):
		moveVector.x = -1
	if Input.is_action_pressed("Move_Right"):
		moveVector.x = 1
	
	if Input.is_action_pressed("Move_Up"):
		moveVector.y = -1
	if Input.is_action_pressed("Move_Down"):
		moveVector.y = 1
		
	velocity += moveVector * Speed * delta
	move_and_slide()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Left_Punch"):
		$LeftHand/Fist1.Use()
	if event.is_action_pressed("Right_Punch"):
		$RightHand/Fist2.Use()
