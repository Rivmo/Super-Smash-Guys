extends Button

@onready var button = self

func _on_pressed() -> void:
	if button.text == "button.on":
		button.text = "button.off"
	elif button.text == "button.off":
		button.text = "button.on"
