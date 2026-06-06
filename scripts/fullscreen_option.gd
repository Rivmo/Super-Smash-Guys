extends Button

@onready var button = self

func _on_pressed() -> void:
	if button.text == "button.on":
		button.text = "button.off"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif button.text == "button.off":
		button.text = "button.on"
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
