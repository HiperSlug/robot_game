extends Area2D

@onready var team_getter: CompGetter = CompGetter.new(
	self.get_parent(),
	Globals.Comp.TEAM,
	CompGetter.FIRST,
)

func _direction() -> Vector2:
	var pos = get_closest_enemy_position()
	if pos == null:
		
		return Vector2.ZERO
	
	var dir_to: Vector2 = global_position.direction_to(pos)
	
	if dir == RIGHT:
		return dir_to.rotated(- TAU / 4)
	else:
		return dir_to.rotated(TAU / 4)

var enemies: Array[Node] = []

func _on_body_entered(body: Node2D) -> void:
	if not team_getter.is_ready:
		await team_getter.ready
	if body.is_in_group(team_getter.first().enemy_group()):
		enemies.append(body)
		if timer.is_stopped():
			timer.start(randf_range(min_swap_time, max_swap_time))

func _on_body_exited(body: Node2D) -> void:
	if not team_getter.is_ready:
		await team_getter.ready
	if body.is_in_group(team_getter.first().enemy_group()):
		enemies.erase(body)
		if enemies.size() == 0:
			timer.stop()

func get_closest_enemy_position():
	if enemies.size() == 0:
		return null
	
	var closest: Vector2 = enemies[0].global_position
	for enemy: Node2D in enemies:
		if position.distance_squared_to(closest) > position.distance_squared_to(enemy.global_position):
			closest = enemy.global_position
	
	return closest



@onready var timer: Timer = $Timer

@export var min_swap_time: float = .5
@export var max_swap_time: float = 1

var dir: int = LEFT

func _on_timer_timeout() -> void:
	timer.start(randf_range(min_swap_time, max_swap_time))
	if dir == RIGHT:
		dir = LEFT
	else:
		dir = RIGHT

enum {
	RIGHT,
	LEFT,
}
