extends Node
# autoload: Network

const PORT := 8080

@onready var main: Main = get_tree().get_first_node_in_group("main")

var team: Globals.Team

var status: Status = Status.OFFLINE
enum Status {
	OFFLINE,
	SERVER,
	CLIENT,
	WAITING_FOR_CLIENT,
	WAITING_FOR_SERVER,
}


func _ready() -> void:
	signals()

func signals() -> void:
	# client
	multiplayer.connected_to_server.connect(on_connected_to_server)
	multiplayer.connection_failed.connect(on_connection_failed)
	#multiplayer.server_disconnected.connect(on_server_disconnected)
	
	# server
	multiplayer.peer_connected.connect(on_peer_connected)
	multiplayer.peer_disconnected.connect(on_peer_disconnected)


func host_match() -> void:
	print("hosting")
	
	status = Status.WAITING_FOR_CLIENT
	team = Globals.random_team()
	
	var peer := ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	multiplayer.multiplayer_peer = peer

func join_match(addr: String) -> void:
	print("joining")
	
	status = Status.WAITING_FOR_SERVER
	
	var peer := ENetMultiplayerPeer.new()
	peer.create_client(addr, PORT)
	multiplayer.multiplayer_peer = peer

func offline() -> void:
	status = Status.OFFLINE
	
	var peer := OfflineMultiplayerPeer.new()
	multiplayer.multiplayer_peer = peer


func on_peer_connected(id: int) -> void:
	if status == Status.WAITING_FOR_CLIENT:
		print("server <-> client")
		status = Status.SERVER
		server_to_client_start_game.rpc_id(id, Globals.enemy(team))
		main.new_game()
		return

@rpc
func server_to_client_start_game(_team: int) -> void:
	team = _team as Globals.Team
	main.new_game()

func on_connected_to_server() -> void:
	if status == Status.WAITING_FOR_SERVER:
		print("client <-> server")
		status = Status.CLIENT
		return

func on_peer_disconnected(id: int) -> void:
	offline()
	main.leave_game()
	print("{0}: disconnected".format([id]))

func on_connection_failed() -> void:
	print("connection failed")
