extends Node2D
class_name TargetClosestEnemyComp

var team: TeamComp = null

func inject_dependencies(dict: Dictionary[StringName, Variant]) -> void:
	if dict.has(&"team_comp"):
		var arr = dict[&"team_comp"]
		if arr is Array and arr.size() == 1 and arr[0] is TeamComp:
			team = arr[0]
	
	if not team:
		printerr("Unable to assign team")

var closest # its so nakey

func target():
	return closest

func _physics_process(_delta: float) -> void:
	closest = get_closest()

func get_closest():
	if not team:
		return null
	
	var enemies := get_tree().get_nodes_in_group(team.enemy_group())
	if enemies.is_empty():
		return null
	
	var closest: Vector2 = enemies[0].global_position
	for enemy: Node2D in enemies:
		if global_position.distance_squared_to(closest) > global_position.distance_squared_to(enemy.global_position):
			closest = enemy.global_position
	
	return closest
