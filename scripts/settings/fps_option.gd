extends SpinBox
func _on_value_changed(newval):
	Engine.max_fps = int(newval)
