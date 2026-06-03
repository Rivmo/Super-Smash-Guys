extends Node2D
var attack_scene: PackedScene = load("res://scenes/attack_default.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_character_attack(dir: int) -> void:
	var attack = attack_scene.instantiate()
	attack.dir = dir
	$CharacterBody2D2.add_child(attack)
	
	
	
