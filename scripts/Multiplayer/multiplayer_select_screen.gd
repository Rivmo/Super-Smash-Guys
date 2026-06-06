extends Control

func _on_exit_multiplayer_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu_screen.tscn")
