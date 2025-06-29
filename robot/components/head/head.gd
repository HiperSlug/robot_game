extends Marker2D
class_name HeadComp



@onready var weapons: CompGetter = CompGetter.new(
	get_parent(),
	Globals.Comp.WEAPON,
	CompGetter.ALL,
)
@onready var closest_enemy_comp: ClosestEnemyPosComp = await CompGetter.new(
	self.get_parent(),
	Globals.Comp.CLOSEST_ENEMY_POS,
	CompGetter.FIRST,
).ready

func _ready() -> void:
	await weapons.ready
	for weapon: CanvasItem in weapons.all():
		weapon.top_level = true

func _physics_process(_delta: float) -> void:
	for weapon: Node2D in weapons.all():
		weapon.global_transform = self.global_transform
	
	
	if not is_multiplayer_authority():
		return
	
	if closest_enemy_comp:
		look_at(closest_enemy_comp.closest())
		rotate(TAU / 4)
