extends CharacterMove

func _idle_ani():
	$Android.play("idle")

func _horizontal_move_ani(flip):
	$Android.play("move")
	$Android.flip_h = flip
	
func _vertical_move_ani(flip):
	$Android.play("fly")
	$Android.flip_h = flip
