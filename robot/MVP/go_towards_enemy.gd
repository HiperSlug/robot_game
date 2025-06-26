extends NavigationAgent2D

@onready var robot: CharacterBody2D = $".."

func _direction() -> Vector2:
	target_position = get_tree().get_first_node_in_group("target").global_position
	
	if is_navigation_finished():
		return Vector2.ZERO
	
	
	return robot.global_position.direction_to(get_next_path_position())
