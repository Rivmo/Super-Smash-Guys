extends CharacterBody2D

@export var knockback = 0
@export var extra_jumps = 2

signal Attack(pos, dir)

const SPEED := 300.0
const JUMP_VELOCITY := -500.0
var Double_jump_count := 0
var playerheight := 0
var Facing := 1
#time between "o" button punch attack
const attack_delay = 2
var attack_delay_absolute_time = 0
var attack_avalible := true

func _ready() -> void:
	position = Vector2(640,450)
	
func _process(delta: float) -> void:
	if attack_avalible != true:
		attack_delay_absolute_time += 1 * delta
	print(attack_delay_absolute_time)
	if attack_delay_absolute_time >= attack_delay:
		attack_delay_absolute_time = 0
		attack_avalible = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		Double_jump_count = 0
	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		elif not Double_jump_count >= extra_jumps:
			velocity.y = JUMP_VELOCITY
			Double_jump_count += 1
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		if abs(direction) > 0:
			Facing = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if Input.is_action_just_pressed("Attack") and attack_avalible == true:
		Attack.emit(Facing)
		attack_avalible = false
	
	move_and_slide()
