extends BaseNavComp
class_name NavStraightComp

var direction: Vector2 = Vector2(randf_range(-1,1), randf_range(-1, 0)).normalized()

func _nav_velocity() -> void:
	robot.velocity = direction * engine.speed
