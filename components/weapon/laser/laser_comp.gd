extends Node2D
class_name Laser

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var laser: Sprite2D = $Laser
@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D

@export var length: float = 0.0 # synched

func set_active(active: bool) -> void:
	ray_cast_2d.set_deferred("enabled", active)
	collision_shape_2d.set_deferred("disabled", not active)
	laser.visible = active


func _process(_delta: float) -> void:
	if is_multiplayer_authority():
		length = get_length()
	
	laser.region_rect.size.y = length
	laser.position = ray_cast_2d.position + Vector2(0, - length / 2)
	
	collision_shape_2d.shape.size.y = length
	collision_shape_2d.position = ray_cast_2d.position + Vector2(0, - length / 2)

func get_length() -> float:
	return (ray_cast_2d.global_position - get_global_raycast_point()).length()

func get_global_raycast_point() -> Vector2:
	if ray_cast_2d.is_colliding():
		return ray_cast_2d.get_collision_point()
	
	return (ray_cast_2d.target_position.length() * Vector2.UP.rotated(global_rotation)) + ray_cast_2d.global_position
