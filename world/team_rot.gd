extends Node
class_name TeamRot

@onready var parent := self.get_parent()

func _ready() -> void:
	match Network.team:
		Globals.Team.ONE:
			parent.rotation = 0
		Globals.Team.TWO:
			parent.rotation = TAU / 2
