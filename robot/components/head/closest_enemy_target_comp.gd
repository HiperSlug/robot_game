extends Marker2D
class_name ClosestEnemyTargetComp


@onready var weapons: CompGetter = CompGetter.new(
	get_parent(),
	Globals.Comp.WEAPON,
	CompGetter.ALL,
)
@onready var closest_enemy_comp: ClosestEnemyPosComp = await CompGetter.new(
	get_parent(),
	Globals.Comp.CLOSEST_ENEMY_POS,
	CompGetter.FIRST,
).ready

func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority():
		if closest_enemy_comp:
			look_at(closest_enemy_comp.closest())
			rotate(TAU / 4)
	
	for weapon: Node2D in weapons.all():
		weapon.global_rotation = self.global_rotation
