extends Node

# multiplayer
# "get_tree().get_multiplayer()." is the same as "multiplayer."

var Server_Port : int = 1111

func create_server():
	var enet_network_peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
	enet_network_peer.create_server(Server_Port)
	get_tree().get_multiplayer().multiplayer_peer = enet_network_peer
	print("made server")
	
func create_client(hosts_IP: String = "localhost", host_Port: int = Server_Port):
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
	get_tree().get_multiplayer().multiplayer_peer = null
