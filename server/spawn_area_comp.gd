extends Area2D
class_name SpawnAreaComp

@export var team: Bot.Team


var choosing: bool = false
const SPAWN_CHOICE = preload("res://server/spawn_choice.tscn")
var current_choice: Control

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("rmb"):
		if not choosing:
			choosing = true
			spawn_choice(get_global_mouse_position())
		else:
			if current_choice:
				current_choice.queue_free()
			spawn_choice(get_global_mouse_position())

func spawn_choice(pos: Vector2) -> void:
	var popup: Control = SPAWN_CHOICE.instantiate()
	add_child(popup)
	current_choice = popup
	popup.global_position = pos
	popup.choice.connect(on_choice)
	popup.mouse_exited.connect(cancell)

func cancell() -> void:
	choosing = false

func on_choice(scene: String) -> void:
	choosing = false
	
	if is_multiplayer_authority():
		spawn(load(scene), current_choice.global_position, team)
	
	else:
		request_spawn.rpc_id(1, scene, current_choice.global_position, team)

@rpc("any_peer")
func request_spawn(scene: String, pos: Vector2, team: Bot.Team) -> void:
	print("Unsafe loading of scene")
	spawn(load(scene), pos, team)

func spawn(scene: PackedScene, pos: Vector2, team: Bot.Team) -> void:
	var robot: Bot = scene.instantiate()
	robot.set_team(team)
	
	get_tree().get_first_node_in_group("visibility_manager").add_child(robot, true)
	robot.global_position = pos
