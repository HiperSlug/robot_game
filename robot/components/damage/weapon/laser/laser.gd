@tool
extends Node2D
class_name Laser

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var laser: Sprite2D = $Laser
@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D

@export var offset_y: float

func _process(_delta: float) -> void:
	var length := get_length()
	
	laser.region_rect.size.y = length + offset_y
	laser.position.y = - length / 2  + offset_y / 2
	
	collision_shape_2d.shape.size.y = length  + offset_y
	collision_shape_2d.position.y = - length / 2  + offset_y / 2


func get_length() -> float:
	return (global_position - get_global_raycast_point()).length()

func get_global_raycast_point() -> Vector2:
	if ray_cast_2d.is_colliding():
		return ray_cast_2d.get_collision_point()
	
	return ray_cast_2d.target_position + ray_cast_2d.global_position
