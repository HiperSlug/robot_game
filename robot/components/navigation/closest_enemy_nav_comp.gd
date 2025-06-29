@tool
extends NavigationAgent2D
class_name ClosestEnemyComp

@onready var team: TeamComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.TEAM,
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
	var closest_pos = get_closest_enemy_position()
	if closest_pos == null:
		return Vector2.ZERO
	
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

func get_closest_enemy_position():
	if not team:
		return null
	var enemies := get_tree().get_nodes_in_group(team.enemy_group())
	if enemies.size() == 0:
		return null
	
	var position: Vector2 = robot.global_position
	
	var closest: Vector2 = enemies[0].global_position
	for enemy: Node2D in enemies:
		if position.distance_squared_to(closest) > position.distance_squared_to(enemy.global_position):
			closest = enemy.global_position
	
	return closest
