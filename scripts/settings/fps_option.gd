extends SpinBox

func _on_value_changed(value: float) -> void:
	Engine.max_fps = self.value
