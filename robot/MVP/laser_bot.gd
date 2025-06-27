extends CharacterBody2D
class_name Bot

var team: Team

func set_team(val: Team) -> void:
	team = val
	
	remove_from_group("team_2")
	remove_from_group("team_1")
	
	match team:
		Team.TEAM_1:
			add_to_group("team_1")
		Team.TEAM_2:
			add_to_group("team_2")
	
	print(get_groups())

enum Team {
	TEAM_1,
	TEAM_2,
}

func enemy_group() -> String:
	match team:
		Team.TEAM_1:
			return ("team_2")
		Team.TEAM_2:
			return ("team_1")
	return ""
