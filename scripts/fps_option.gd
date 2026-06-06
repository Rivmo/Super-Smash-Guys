extends SpinBox

func _on_changed() -> void:
	Engine.max_fps = self.value
