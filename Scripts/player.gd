extends CharacterBody2D

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var braking : float = 20
@export var gravity : float = 500
@export var jump_force : float = 200

@onready var sprite : Sprite2D = $PlayerSprite

var move_input : float

func _physics_process(delta: float) -> void:
	
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Movement Input
	move_input = Input.get_axis("move_left","move_right")
	
	# Movement
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
	
	# Add your jumping code here.
	
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0
