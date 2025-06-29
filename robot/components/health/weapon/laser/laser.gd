extends Node2D
class_name Laser



@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var laser: Sprite2D = $Laser
@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D

@export var offset_y: float
@export var distance: float = 200:
	set(val):
		distance = val
		ray_cast_2d.target_position = Vector2(0, -distance)


@onready var closest_enemy: CompGetter = CompGetter.new(
	get_parent(),
	Globals.Comp.CLOSEST_ENEMY_POS,
	CompGetter.FIRST,
)

@export var length: float = 0.0 # synched


func _ready() -> void:
	deactive()

func activate() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	laser.show()

func deactive() -> void:
	collision_shape_2d.set_deferred("disabled", true)
	laser.hide()

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if not closest_enemy.is_ready:
			return
		if global_position.distance_squared_to(closest_enemy.first().closest()) < distance ** 2:
			activate()
		else:
			deactive() 

func _process(_delta: float) -> void:
	
	if is_multiplayer_authority():
		length = get_length()
		
	
	var clipped_len := maxf(length, - offset_y)
	
	laser.region_rect.size.y = clipped_len + offset_y
	laser.position.y = - clipped_len / 2  + offset_y / 2
	
	collision_shape_2d.shape.size.y = clipped_len  + offset_y
	collision_shape_2d.position.y = - clipped_len / 2  + offset_y / 2


func get_length() -> float:
	return (global_position - get_global_raycast_point()).length()

func get_global_raycast_point() -> Vector2:
	if ray_cast_2d.is_colliding():
		return ray_cast_2d.get_collision_point()
	
	return (ray_cast_2d.target_position.length() * Vector2.UP.rotated(global_rotation)) + ray_cast_2d.global_position
