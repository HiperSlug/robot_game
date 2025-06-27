extends Node
class_name NavForwardComp

@onready var robot: CharacterBody2D = self.get_parent()

func _direction() -> Vector2:
	return Vector2.UP.rotated(robot.rotation)
