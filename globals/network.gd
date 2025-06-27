extends Node
# autoload: Network

const PORT := 8080

func create_server() -> void:
	var peer := ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer
	connect_signals(peer)

func create_client(addr: String) -> void:
	var peer := ENetMultiplayerPeer.new()
	peer.create_client(addr, PORT)
	multiplayer.multiplayer_peer = peer
	connect_signals(peer)


func connect_signals(peer: ENetMultiplayerPeer) -> void:
	peer.peer_connected.connect(on_connected)
	peer.peer_disconnected.connect(on_disconnected)

func on_connected(id: int) -> void:
	print("{0}: connected".format([id]))

func on_disconnected(id: int) -> void:
	print("{0}: disconnected".format([id]))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("network_client"):
		print("client")
		create_client("localhost")
	elif event.is_action_pressed("network_server"):
		print("server")
		create_server()
