class_name CharacterMove
extends CharacterBody2D

# how fast the player is
@export var move_speed := 400
@export var jump_speed := 600

# world boundaries
@export var fallLine := 400

var start : Vector2 # spawn location


func _ready() -> void:
	start = position # sets up spawn location


# checks to make sure character is not out of bounds
func _check_outside():
	if position.y > fallLine:
		_failure()


# what happens if this character dies
func _failure():
	position = start


# updates horizontal (x) velocity. Default works for basic player movement
func _horizontal_input() -> void:
	# if player presses left movement option, velocity decreases by player speed
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
		
	# if player presses right movement option, velocity increases by player speed
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
		
	if Input.is_action_pressed("down"):
		velocity.y += move_speed


# updates vertical (y) velocity. Default works for basic player movement
func _vertical_input() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed


# gets horizontal and vertical inputs for velocity
func _user_input() -> void:
	_horizontal_input()
	_vertical_input()


# what it looks like with no character movement
func _idle_ani():
	pass


# what it looks like going in a horizontal direction
func _horizontal_move_ani(flip_h : bool):
	pass

# what it looks like when moving in a vertical direction
func _vertical_move_ani(flip_h : bool):
	pass

# has basic animation logic. Vertical animation for vertical movement, 
# horizontal animation for only moving horizontally, and if neither, an idle animation
func _animation():
	#adjusts left or right depending where player goes
	var flip = true if velocity.x < 0 else false
	
	# jump
	if velocity.y != 0:
		_vertical_move_ani(flip)
	
	# move left/right no jump
	elif velocity.x != 0 and velocity.y == 0:
		_horizontal_move_ani(flip)
	# default animation, no movement
	
	else:
		_idle_ani()


func _physics_process(delta: float) -> void:
	_check_outside() # check if out of bounds
	
	velocity.x = 0
	
	_user_input() # get velocity vector from user input
	_animation()
	
	# account gravity into velocity
	velocity += get_gravity() * delta
	
	# takes velocity and puts it into positon with collision detection
	move_and_slide()
