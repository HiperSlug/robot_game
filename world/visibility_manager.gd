extends Polygon2D
class_name VisibilityManager

@export var enabled: bool = true

var _polygon := PackedVector2Array()
var _polygons: Array[PackedInt32Array] = []

func update_visibility(vis_polygon: PackedVector2Array) -> void:
	_polygons.append(PackedInt32Array(range(
				_polygon.size(), 
				vis_polygon.size() + _polygon.size()
				)))
	
	_polygon.append_array(vis_polygon)
	

func _physics_process(_delta: float) -> void:
	if not enabled:
		polygon = PackedVector2Array()
		polygons = []
		return
	
	
	if _polygon.is_empty():
		_polygon = PackedVector2Array([Vector2(0,0), Vector2(0,0), Vector2(0,0)])
	
	
	polygon = _polygon
	polygons = _polygons
	_polygon = PackedVector2Array()
	_polygons = []
