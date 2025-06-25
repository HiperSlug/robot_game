@tool
extends Area2D
class_name CameraComp

@onready var polygon: ExpandingCone2D = $Polygon
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


func global_polygon() -> PackedVector2Array:
	return PackedVector2Array(Array(polygon.polygon).map(func(p): return p + global_position))


func _on_polygon_changed(new_polygon: PackedVector2Array) -> void:
	collision_polygon_2d.polygon = new_polygon
