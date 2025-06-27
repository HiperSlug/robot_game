extends Node
# autoload: Network

@onready var main: Main = get_tree().get_first_node_in_group("main")

func _ready() -> void:
	signals()

const PORT := 8080

func create_server() -> void:
	network_disconnect()
	
	print("hosting")
	
	var peer := ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer

func create_client(addr: String) -> void:
	network_disconnect()
	
	print("joining")
	
	var peer := ENetMultiplayerPeer.new()
	peer.create_client(addr, PORT)
	multiplayer.multiplayer_peer = peer

func network_disconnect() -> void:
	var peer := OfflineMultiplayerPeer.new()
	multiplayer.multiplayer_peer = peer

func signals() -> void:
	# client
	multiplayer.connected_to_server.connect(on_connected_to_server)
	multiplayer.connection_failed.connect(on_connection_failed)
	multiplayer.server_disconnected.connect(on_server_disconnected)
	
	# server
	multiplayer.peer_connected.connect(on_client_connected)
	multiplayer.peer_disconnected.connect(on_client_disconnected)

func on_client_connected(id: int) -> void:
	print("{0}: connected to server".format([id]))

func on_client_disconnected(id: int) -> void:
	print("{0}: disconnected from server".format([id]))

func on_connected_to_server() -> void:
	print("connected to server")

func on_connection_failed() -> void:
	print("connection failed")


func on_server_disconnected() -> void:
	network_disconnect()
	main.end_match()
	print("server disconnected")
