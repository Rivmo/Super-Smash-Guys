extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _on_join_pressed() -> void:
	visible = true

func _on_text_submitted(text: String) -> void:
	print(text)
