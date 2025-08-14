extends CharacterMove

# character abilities
@export var hasDoubleJump := false
@export var hasWallJump := false
@export var wallKickback := 3

var doubleJumpReady := true # tracker for jumps


func _jump():
	velocity.y = -sqrt(2 * get_gravity().y * jump_height)
	SoundManager.jump()


func _double_jump():
	if hasDoubleJump and doubleJumpReady:
		_jump()
		doubleJumpReady = false


func _wall_jump():
	if hasWallJump:
		_jump()
		doubleJumpReady = false # removes extra jumps when wall jumping
		
		#wall kickback
		if velocity.x < 0:
			velocity.x = move_speed * wallKickback
		else:
			velocity.x = -(move_speed) * wallKickback


func _vertical_input():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			_jump()
			doubleJumpReady = true # resets count on floor
		elif is_on_wall():
			_wall_jump()
		else:
			_double_jump()


func _idle_ani():
	$Druid.play("idle")


func _horizontal_move_ani(flip):
	$Druid.play("move")
	$Druid.flip_h = flip


func _vertical_move_ani(flip):
	# animation depends on arc, whether going up or down
	if velocity.y < 0:
		$Druid.play("jump") # switch to jump animation
	else:
		$Druid.play("fall") # switch to falling animation
	
	# facing left or right
	$Druid.flip_h = flip


func _on_switch() -> void:
	$Camera2D.enabled = move_enabled
