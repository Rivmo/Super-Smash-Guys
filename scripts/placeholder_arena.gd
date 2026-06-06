extends Node2D
var attack_scene: PackedScene = load("res://scenes/attack_default.tscn")
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	
	if time >= 0:
		time -= 1 * delta
	else:
		var attack = attack_scene.instantiate()
		attack.dir = -1
		$Dummy.add_child(attack)
		time = 2


func _on_character_attack(dir: int) -> void:
	var attack = attack_scene.instantiate()
	attack.dir = dir
	
	$Player.add_child(attack)
	
	
	
