extends CharacterBody2D

@export var knockback = 0
@export var extra_jumps = 2

const SPEED := 300.0
const JUMP_VELOCITY := -500.0
var Double_jump_count := 0
var playerheight := 0

func _ready() -> void:
	position = Vector2(640,400)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	

	# Handle jump.
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			Double_jump_count = 0
		elif not Double_jump_count >= extra_jumps:
			velocity.y = JUMP_VELOCITY
			Double_jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
