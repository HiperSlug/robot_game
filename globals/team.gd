extends RefCounted
class_name Team

enum {
	ONE = 1,
	TWO = 2,
	NONE = 0,
}

const TEAM_NAMES := {
	ONE: &"team_1",
	TWO: &"team_2",
	NONE: &"",
}

static func team_group(team: int) -> StringName:
	return TEAM_NAMES[team]

static func enemy_group(team: int) -> StringName:
	return TEAM_NAMES[enemy(team)]

static func random_team() -> int:
	return ONE if randi() % 2 == 0 else TWO

static func enemy(team: int) -> int:
	match team:
		ONE:
			return TWO
		TWO:
			return ONE
		_:
			return NONE
