extends Node
class_name TeamComp

@export var team: Globals.Team: set = set_team

func enemy_group() -> StringName:
	return Globals.team_group(Globals.enemy(team))

func friendly_group() -> StringName:
	return Globals.team_group(team)

@onready var robot: CharacterBody2D = self.get_parent()

func set_team(new_team: Globals.Team) -> void:
	team = new_team
	robot.remove_from_group(enemy_group())
	robot.add_to_group(friendly_group())
