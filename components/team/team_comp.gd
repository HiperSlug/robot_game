extends Node
class_name TeamComp

var team: int = Team.NONE
var target: Node = null

func inject_dependencies(dict: Dictionary) -> void:
	if dict.has(&"character"):
		var character = dict[&"character"]
		if character and character is Node:
			target = character
	
	if not target:
		printerr("Unable to assign target.")
	
	set_group()

func set_group() -> void:
	if target:
		target.remove_from_group(Team.enemy_group(team))
		target.remove_from_group(Team.team_group(team))
		target.add_to_group(Team.team_group(team))

@export_enum("NO_OVERRIDE:-1", "NONE:0", "ONE:1", "TWO:2") var team_override: int = -1

func _ready() -> void:
	if team_override != -1:
		team = team_override


func enemy_group() -> StringName:
	return Team.enemy_group(team)

func team_group() -> StringName:
	return Team.team_group(team)
