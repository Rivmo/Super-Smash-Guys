extends Node2D

@export var dir = 2
@export var move_time = 0.5
@export var Movement_speed = 500
var time = 0
var Movement_speed_time = Movement_speed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Movement_speed *= dir
	Movement_speed_time = Movement_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time < move_time :
		position.x += Movement_speed_time * delta
		Movement_speed_time -= 2 * Movement_speed/move_time * delta
		print(time, delta)
		time += delta
		
	else:
		self.free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	#handle hitting the dummy with attack
	if body.name == "Dummy" and get_parent().name != "Dummy":
		body.knockback += 10
		var knockback = body.knockback * 4
		body.apply_impulse(Vector2(dir*(400+knockback),10))
	elif body.name == "Player" and get_parent().name != "Player":
		body.knockback += 10
		var knockback = body.knockback * 200
		body.velocityxk += dir*(40000+knockback)
		body.velocityyk += 10
		body.stuntime = 0.2
		
