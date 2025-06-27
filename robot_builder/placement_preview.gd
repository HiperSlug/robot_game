extends Area2D
class_name PlacementPreview

var components: Array[Component]

func initalize(components: Array[Component]) -> void:
	self.components = components

var placing: bool = true

var overlapping: Array = []

func not_overlapping() -> bool:
	return overlapping.size() == 0

func _on_body_entered(body: Node2D) -> void:
	overlapping.append(body)

func _on_body_exited(body: Node2D) -> void:
	overlapping.erase(body)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("lmb"):
		if placing:
			create_robot(global_position)

func _process(_delta: float) -> void:
	if placing:
		global_position = get_global_mouse_position()


const ROBOT = preload("res://robot/robot.tscn")
func create_robot(pos: Vector2) -> void:
	var robot: CharacterBody2D = ROBOT.instantiate()
	for componenet: Component in components:
		var comp = componenet.scene.instantiate()
		robot.add_child(comp, true)
	get_tree().get_first_node_in_group("visibility_manager").add_child(robot, true)
	robot.global_position = pos
	
	queue_free()
