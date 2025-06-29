extends Node2D
class_name Bomb

@export var distance: float = 100

@onready var closest_enemy: CompGetter = CompGetter.new(
	get_parent(),
	Globals.Comp.CLOSEST_ENEMY_POS,
	CompGetter.FIRST,
)


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if not closest_enemy.is_ready:
			return
		if global_position.distance_squared_to(closest_enemy.first().closest()) < distance ** 2:
			explode()

@onready var collision_shape_2d: CollisionShape2D = $Hitbox/CollisionShape2D
func explode() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	print("boom")
