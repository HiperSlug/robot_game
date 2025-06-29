extends Node
class_name TeamRot


func _ready() -> void:
	match Network.team:
		Team.ONE:
			get_parent().rotation = 0
		Team.TWO:
			get_parent().rotation = TAU / 2
