extends CharacterBody2D

@export var move_speed : float = 100
@export var acceleration : float = 50
@export var braking : float = 20
@export var gravity : float = 500
@export var jump_force : float = 200

@onready var sprite : Sprite2D = $PlayerSprite

var move_input : float

func _physics_process(delta: float) -> void:
	
	apply_gravity(delta)
	
	get_movement_input()
	
	apply_movement(delta)
	
	jump()
	
	move_and_slide()
	
func _process(delta: float) -> void:
	if velocity.x != 0:
		sprite.flip_h = velocity.x > 0
		
func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func get_movement_input():
	move_input = Input.get_axis("move_left","move_right")
	
func apply_movement(delta):
	if move_input != 0:
		velocity.x = lerp(velocity.x, move_input * move_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, braking * delta)
		
func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	
