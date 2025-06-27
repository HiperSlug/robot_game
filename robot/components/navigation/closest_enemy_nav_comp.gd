@tool
extends NavigationAgent2D
class_name ClosestEnemyComp

@onready var team: TeamComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.TEAM,
	CompGetter.FIRST,
).ready
@onready var robot: CharacterBody2D = self.get_parent()

@export var distance: float:
	set(val):
		distance = val
		target_desired_distance = distance


func _direction() -> Vector2:
	var closest_pos = get_closest_enemy_position()
	if closest_pos == null:
		return Vector2.ZERO
	
	var inside_range: bool = closest_pos.distance_squared_to(robot.global_position) < distance ** 2
	if is_target_reached() and inside_range:
		return Vector2.ZERO
	
	target_position = closest_pos
	
	var dir = robot.global_position.direction_to(get_next_path_position())
	return dir

func get_closest_enemy_position():
	var enemies := get_tree().get_nodes_in_group(team.enemy_group())
	if enemies.size() == 0:
		return null
	
	var position: Vector2 = robot.global_position
	
	var closest: Vector2 = enemies[0].global_position
	for enemy: Node2D in enemies:
		if position.distance_squared_to(closest) > position.distance_squared_to(enemy.global_position):
			closest = enemy.global_position
	
	return closest
