extends CharacterBody2D
class_name Robot

@export var team: TeamComp

func _ready() -> void:
	DependencyInjector.handle_comp_dependencies(self)
