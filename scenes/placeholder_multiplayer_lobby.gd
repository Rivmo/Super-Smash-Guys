extends Control



func _on_exit_multiplayer_pressed() -> void:
	NetworkManager.leave_game_load_menu()
