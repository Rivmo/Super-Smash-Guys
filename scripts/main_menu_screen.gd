extends Control

# all buttons
func _on_practice_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/placeholder_arena.tscn") 

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings_menu_screen.tscn")
