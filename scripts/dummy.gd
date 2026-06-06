extends RigidBody2D

@export var knockback = 0

func _ready() -> void:
	position = Vector2(640,450)
	
func _process(delta: float) -> void:
	#handle health bar
	var green = $Green
	green.scale.x = 100 - knockback/3 
	green.position.x = -knockback/6 - 1
