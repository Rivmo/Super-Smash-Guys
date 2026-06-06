extends ColorRect

func _ready() -> void:
	visible = false

func _on_back_to_game_pressed() -> void:
	visible = false

func _on_button_pressed() -> void:
	visible = true
