extends CharacterMove

@export var fly = false
@export var interface = false

func _up():
	velocity.y = -sqrt(2 * get_gravity().y * jump_height)

func _vertical_input():
	if Input.is_action_pressed("jump"):
		if is_on_floor() or fly:
			_up()

func _idle_ani():
	$Android.play("idle")


func _horizontal_move_ani(flip):
	$Android.play("move")
	$Android.flip_h = flip


func _vertical_move_ani(flip):
	$Android.play("fly")
	$Android.flip_h = flip


func _on_switch() -> void:
	$Camera2D.enabled = move_enabled
