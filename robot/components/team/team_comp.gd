extends Node
class_name TeamComp

@export var override: bool = false
@export var team_override: Globals.Team

var team: Globals.Team

@onready var robot: Node2D = self.get_parent()

func enemy_group() -> StringName:
	return Globals.team_group(Globals.enemy(team))

func friendly_group() -> StringName:
	return Globals.team_group(team)

func _ready() -> void:
	if override:
		team = team_override
	robot.remove_from_group(enemy_group())
	robot.add_to_group(friendly_group())
