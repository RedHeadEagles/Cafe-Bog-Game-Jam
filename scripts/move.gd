extends CharacterBody2D

# how fast the player is
@export var move_speed = 1000
@export var jump_speed = 25000

func _ready() -> void:
	pass

# takes input and inserts it into velocity
func user_input() -> void:
	# if player presses left movement option, velocity decreases by player speed
	if Input.is_action_pressed("left"):
		velocity.x -= move_speed
		
	# if player presses right movement option, velocity increases by player speed
	if Input.is_action_pressed("right"):
		velocity.x += move_speed
		
	if Input.is_action_pressed("down"):
		velocity.y += move_speed
	
	# if player presses jump movement option and is on ground, increase in height
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump_speed

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	user_input()
	velocity += get_gravity()
	move_and_slide()
