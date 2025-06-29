extends StaticBody2D
class_name Server

func _ready() -> void:
	DependencyInjector.handle_comp_dependencies(self)
