extends Node2D
class_name RifleComp

@export var distance: float = 200
@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D

@onready var closest_enemy: CompGetter = CompGetter.new(
	get_parent(),
	Globals.Comp.CLOSEST_ENEMY_POS,
	CompGetter.FIRST,
)


func _ready() -> void:
	deactive()

func activate() -> void:
	if timer.is_stopped():
		shoot()
		timer.start()

func deactive() -> void:
	timer.stop()

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if not closest_enemy.is_ready:
			return
		if global_position.distance_squared_to(closest_enemy.first().closest()) < distance ** 2:
			activate()
		else:
			deactive() 

const BULLET = preload("res://robot/components/health/weapon/rifle/bullet.tscn")
func shoot() -> void:
	var bullet = BULLET.instantiate()
	bullet.inital_dir(Vector2.UP.rotated(rotation))
	bullet.position = marker_2d.global_position
	get_tree().get_first_node_in_group("visibility_manager").add_child(bullet, true)


func _on_timer_timeout() -> void:
	shoot()
