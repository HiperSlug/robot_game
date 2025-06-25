extends BaseAttackComp
class_name LaserComp

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D

func _process(_delta: float) -> void:
	var length := get_length()
	remote_transform_2d.position.y = - length / 2
	remote_transform_2d.scale.y = (length / 8)

func get_length() -> float:
	return (global_position - get_global_raycast_point()).length()

func get_global_raycast_point() -> Vector2:
	if ray_cast_2d.is_colliding():
		return ray_cast_2d.get_collision_point()
	
	return ray_cast_2d.target_position + ray_cast_2d.global_position
