extends NavComp
class_name NavForwardComp

@onready var robot: Robot = $".."

func _direction() -> Vector2:
	return Vector2.UP.rotated(robot.rotation)
