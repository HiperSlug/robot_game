extends Area2D
class_name SpawnAreaComp

var team: TeamComp = null

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"team_comp"):
		var arr = dict[&"team_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is TeamComp:
			team = arr[0]
	
	if not team:
		printerr("Unable to assign team")

const TEAM_COMP = preload("res://components/team/team_comp.tscn")
const SPAWN_CHOICE = preload("res://ui/spawn/spawn_choice.tscn")

var current_choice: Control

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if Network.team != Team.NONE and Network.team != team.team:
		return
	
	if event.is_action_pressed("rmb"):
		if current_choice:
			current_choice.queue_free()
		spawn_choice(get_global_mouse_position())

func spawn_choice(pos: Vector2) -> void:
	var popup: Control = SPAWN_CHOICE.instantiate()
	add_child(popup)
	current_choice = popup
	popup.global_position = pos
	
	popup.choice.connect(on_choice)
	popup.mouse_exited.connect(cancel)

func cancel() -> void:
	current_choice = null

func on_choice(scene_path: String) -> void:
	if is_multiplayer_authority():
		server_spawn(load(scene_path), current_choice.global_position, team.team)
	else:
		request_spawn.rpc_id(1, scene_path, current_choice.global_position, team.team)
	
	current_choice = null

@rpc("any_peer")
func request_spawn(scene_path: String, pos: Vector2, team: int) -> void:
	print("validate")
	server_spawn(load(scene_path), pos, team)

func server_spawn(scene: PackedScene, pos: Vector2, team: int) -> void:
	var robot: CharacterBody2D = scene.instantiate()
	
	var team_comp := TEAM_COMP.instantiate()
	team_comp.team = team
	robot.add_child(team_comp, true)
	
	get_tree().get_first_node_in_group("visibility_manager").add_child(robot, true)
	robot.global_position = pos
