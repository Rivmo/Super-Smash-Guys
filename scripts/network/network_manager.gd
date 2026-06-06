extends Node

# multiplayer
# "get_tree().get_multiplayer()." is the same as "multiplayer."
var Server_Port : int = 1111

var is_host = false

func create_server():
	is_host = true
	var enet_network_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	enet_network_peer.create_server(Server_Port)
	get_tree().get_multiplayer().multiplayer_peer = enet_network_peer
	print("made server")
	
func create_client(hosts_IP: String = "localhost", host_Port: int = Server_Port):
	is_host = false
	_setup_client_connection_signals()
	var enet_network_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	enet_network_peer.create_client(hosts_IP, host_Port)
	get_tree().get_multiplayer().multiplayer_peer = enet_network_peer
	print("client peer created")

func _setup_client_connection_signals():
	if not get_tree().get_multiplayer().server_disconnected.is_connected(_server_disconnect):
		get_tree().get_multiplayer().server_disconnected.connect(_server_disconnect)
		
func _server_disconnect():
	print("server disconnected")
	leave_game_load_menu()
	
func lobby_join():
	print("joined lobby")
	get_tree().call_deferred(&"change_scene_to_packed", preload("res://scenes/placeholder_multiplayer_lobby.tscn"))


func _lobby_leave():
	print("joined lobby")
	get_tree().call_deferred(&"change_scene_to_packed", preload("res://scenes/Multiplayer_select_screen.tscn"))

func _leave_game():
	get_tree().get_multiplayer().multiplayer_peer = null
	
func leave_game_load_menu():
	print("Terminated connection")
	_lobby_leave()
	_leave_game()
	_dissconnect_cilent()

func _dissconnect_cilent():
	if get_tree().get_multiplayer().server_disconnected.has_connections():
		get_tree().get_multiplayer().server_disconnected.disconnect(_server_disconnect)
