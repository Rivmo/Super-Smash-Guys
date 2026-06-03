extends Node2D

@export var dir = 1
@export var move_time = 15
@export var Movement_speed = 300
var time := 0
var Movement_speed_time = Movement_speed
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Movement_speed *= dir
	Movement_speed_time = Movement_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if time < move_time :
		position.x += Movement_speed_time * delta
		print(Movement_speed_time)
		Movement_speed_time -= 2*Movement_speed/(move_time)
		time += 1
	else:
		self.free()
	
