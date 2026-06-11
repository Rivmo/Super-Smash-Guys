extends LineEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	

	
func _on_join_pressed() -> void:
	visible = true
	
func _on_host_pressed() -> void:
	NetworkManager.create_server()
	NetworkManager.lobby_join()

func _on_button_pressed() -> void:
	_send_test_message.rpc("hi")
	
@rpc("any_peer", "call_remote")

func _send_test_message(message: String):
	print("Message [%s] received on peer [%s], from peer [%s]" %
		[message,
		get_tree().get_multiplayer().get_unique_id(),
		get_tree().get_multiplayer().get_remote_sender_id()])

func _on_join_text_submitted(new_text: String) -> void:
	var code := NetworkManager.Server_Port
	if int(text) == code:
		NetworkManager.lobby_join()
		NetworkManager.create_client()
