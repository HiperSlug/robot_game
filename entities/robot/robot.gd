extends CharacterBody2D
class_name Robot

func _ready() -> void:
	DependencyInjector.handle_comp_dependencies(self)
