extends Node2D
var attack_scene: PackedScene = load("res://scenes/attack_default.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
func _on_character_attack(dir: int) -> void:
	var attack = attack_scene.instantiate()
	attack.dir = dir
	
	$Player.add_child(attack)
	
	
	
