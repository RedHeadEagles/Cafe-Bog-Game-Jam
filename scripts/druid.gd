extends CharacterMove

# character abilities
@export var hasDoubleJump := false
@export var hasWallJump := false
@export var wallKickback := 3

var doubleJumpReady := 2 # tracker for jumps

func _vertical_input():
	if hasWallJump:
		if is_on_wall():
			doubleJumpReady = doubleJumpReady + 1 if doubleJumpReady < 2 else 2
			if Input.is_action_just_pressed("jump") and (doubleJumpReady > 0):
				velocity.y = -jump_height
				doubleJumpReady -= 1
				if velocity.x < 0:
					velocity.x = move_speed * wallKickback
				else:
					velocity.x = -(move_speed) * wallKickback
	
	if hasDoubleJump:
		if is_on_floor():
			doubleJumpReady = 2
		if Input.is_action_just_pressed("jump") and (doubleJumpReady > 0):
			velocity.y = -sqrt(2 * get_gravity().y * jump_height)
			doubleJumpReady -= 1
	else:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = -sqrt(2 * get_gravity().y * jump_height)


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
