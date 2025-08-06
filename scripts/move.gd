extends CharacterBody2D

# how fast the player is
@export var speed = 1000
var gravity = 9.8

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	# if player presses left movement option, velocity decreases by player speed
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		
	# if player presses right movement option, velocity increases by player speed
	if Input.is_action_pressed("right"):
		velocity.x += 1
		
	if Input.is_action_pressed("down"):
		velocity.y += 1
	
	# if player presses jump movement option, increase in height
	if Input.is_action_pressed("jump"):
		velocity.y -= 1
	
	# normalize the movement vector and add gravity in
	velocity = velocity.normalized() * speed * delta 
	
	# use results in the position
	position += velocity #+ get_gravity()
	
	
