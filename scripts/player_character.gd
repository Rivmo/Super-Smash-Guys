extends CharacterBody2D

#no use
@export var knockback = 0
@export var extra_jumps = 1
#time between punch attack in seconds
@export var attack_delay = 1
@export var dash_delay = 1

signal Attack(pos, dir)

const SPEED := 300.0
const JUMP_VELOCITY := -500.0
var Double_jump_count := 0
var playerheight := 0
var Facing = 1
var attack_delay_absolute_time = 0
var attack_available := true
var dash_available := true
var dash_speed := 4
var dash_delay_absolute_time = 0
var dashing_delay_absolute_time = 0
var dash_direction := 0
var is_dashing := false
var is_crouching := false

func _ready() -> void:
	position = Vector2(240,450)
	
func _process(delta: float) -> void:
	#process cooldowns
	
	if attack_available != true:
		attack_delay_absolute_time += 1 * delta
	if attack_delay_absolute_time >= attack_delay:
		attack_delay_absolute_time = 0
		attack_available = true
		
	if dash_available != true:
		dash_delay_absolute_time += 1 * delta
	if dash_delay_absolute_time >= dash_delay:
		dash_delay_absolute_time = 0
		dash_available = true
	
	if is_dashing == true:
		dashing_delay_absolute_time += 1 * delta
	if dashing_delay_absolute_time >= 0.25:
		dashing_delay_absolute_time = 0
		is_dashing = false
	

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
	
	#Handle dashing inputs & input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Left", "Right")
	if Input.is_action_just_pressed("Dash") and dash_available:
		dash_available = false
		is_dashing = true
		dash_direction = Facing
		velocity.x += direction * dash_speed
	if is_dashing:
			velocity.x =   SPEED * dash_speed * dash_direction
	if direction:
		if not is_dashing:
			velocity.x = direction * SPEED
		if abs(direction) > 0:
				Facing = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	#emit attack signal on attack input
	if Input.is_action_just_pressed("Attack") and attack_available == true:
		Attack.emit(Facing)
		attack_available = false
		
	#Handle crouch inputs	
	if Input.is_action_just_pressed("Crouch"):
		scale.y = 0.5
		position.y += 51
	if Input.is_action_just_released("Crouch"):
		scale.y = 1

		
	move_and_slide()
