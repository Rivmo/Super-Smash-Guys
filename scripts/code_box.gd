extends Label

func _ready() -> void:
	text = str(NetworkManager.Server_Port)
