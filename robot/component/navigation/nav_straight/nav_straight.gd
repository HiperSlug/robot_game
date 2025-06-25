extends BaseNavComp
class_name NavStraightComp

func _direction() -> Vector2:
	return Vector2.UP.rotated(robot.rotation)
