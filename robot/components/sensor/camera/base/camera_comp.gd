extends Area2D
class_name CameraComp

@onready var camera_cone: CameraCone = $Polygon

func global_polygon() -> PackedVector2Array:
	return PackedVector2Array(Array(camera_cone.polygon).map(func(p): return p + global_position))
