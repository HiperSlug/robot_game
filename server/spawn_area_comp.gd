extends Area2D
class_name SpawnAreaComp

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
	popup.choice.connect(spawn)
	popup.mouse_exited.connect(cancell)

func cancell() -> void:
	choosing = false

func spawn(scene: PackedScene, pos: Vector2) -> void:
	choosing = false
	var robot = scene.instantiate()
	add_child(robot)
	robot.global_position = pos
