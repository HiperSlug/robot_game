extends Node
# autoload Globals

enum Team {
	ONE,
	TWO,
}

const TEAM_NAMES := {
	Team.ONE: &"team_1",
	Team.TWO: &"team_2",
}

func team_group(team: Team) -> StringName:
	return TEAM_NAMES[team]

func random_team() -> Team:
	return Team.ONE if randi() % 2 == 0 else Team.TWO

func enemy(team: Team) -> Team:
	match team:
		Team.ONE:
			return Team.TWO
		Team.TWO:
			return Team.ONE
	
	return Team.ONE # ridiculous I have to add this.

enum Comp {
	DEATH,
	ENGINE,
	HEALTH,
	HEALTH_MANAGER,
	HURTBOX,
	NAV,
	NAV_MANAGER,
	WEAPON,
	TEAM,
}# TODO Communication, Sensor

const COMP_NAMES := {
	Comp.DEATH: &"death_comp",
	Comp.ENGINE: &"engine_comp",
	Comp.HEALTH: &"health_comp",
	Comp.HEALTH_MANAGER: &"health_manager_comp",
	Comp.HURTBOX: &"hurtbox_comp",
	Comp.NAV: &"nav_comp",
	Comp.NAV_MANAGER: &"nav_manager_comp",
	Comp.WEAPON: &"weapon_comp",
	Comp.TEAM: &"team_comp",
}

func group(comp: Comp) -> StringName:
	return COMP_NAMES[comp]
