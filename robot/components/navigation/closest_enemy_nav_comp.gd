@tool
extends NavigationAgent2D
class_name ClosestEnemyComp

@onready var closest_enemy_comp: ClosestEnemyPosComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.CLOSEST_ENEMY_POS,
	CompGetter.FIRST,
).ready


@export var distance: float = 180:
	set(val):
		distance = val
		target_desired_distance = distance

const desired_leeway := 20.0

var robot: Node:
	get:
		return get_parent()

func _ready() -> void:
	target_position = robot.global_position


func _direction() -> Vector2:
	if not closest_enemy_comp:
		return Vector2.ZERO
	
	if not closest_enemy_comp.valid():
		return Vector2.ZERO
	
	var closest_pos = closest_enemy_comp.closest()
	
	if is_target_reached():
		var dist: float = closest_pos.distance_to(robot.global_position)
		if dist < distance - desired_leeway:
			return closest_pos.direction_to(robot.global_position)
		elif dist > distance:
			target_position = closest_pos
		else:
			return Vector2.ZERO
	
	target_position = closest_pos
	
	var dir = robot.global_position.direction_to(get_next_path_position())
	return dir
