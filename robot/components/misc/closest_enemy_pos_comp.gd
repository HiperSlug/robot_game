extends Node2D
class_name ClosestEnemyPosComp

@onready var team: TeamComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.TEAM,
	CompGetter.FIRST,
).ready

func _physics_process(_delta: float) -> void:
	var pos = get_closest_enemy_position()
	if pos:
		closest_pos = pos
		is_closest = true
	else:
		is_closest = false

var closest_pos: Vector2 = Vector2.ZERO
var is_closest: bool = false


func valid() -> bool:
	return is_closest

func closest() -> Vector2:
	return closest_pos

func get_closest_enemy_position():
	if not team:
		return null
	
	var enemies := get_tree().get_nodes_in_group(team.enemy_group())
	if enemies.size() == 0:
		return null
	
	
	var closest: Vector2 = enemies[0].global_position
	for enemy: Node2D in enemies:
		if global_position.distance_squared_to(closest) > global_position.distance_squared_to(enemy.global_position):
			closest = enemy.global_position
	
	return closest
