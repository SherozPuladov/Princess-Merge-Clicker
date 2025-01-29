extends Node



signal princess_spawned(princess: Princess)
signal not_enough_crystals_to_buy_princess(missing_crystals: int)
signal princess_level_increased(princess: Princess)
signal princess_bought()



const bodies: Bodies = preload('res://data/princesses/bodies.tres')
const dresses: Dresses = preload('res://data/princesses/dresses.tres')
const button_textures: PrincessButtonTextures = preload('res://data/princesses/button_textures.tres')
const level_costs: PrincessLevelCosts = preload('res://data/princesses/level_costs.tres')
const level_names: PrincessLevelNames = preload('res://data/princesses/level_name.tres')
const level_crystals: PrincessLevelCrystals = preload('res://data/princesses/level_crystals.tres')
const hairs: Hairs = preload('res://data/princesses/hairs.tres')

const princess_scene = preload("res://scenes/objects/Princess.tscn")

const MAX_PRINCESSES_ON_SCENE = 32
const MAX_PRINCESS_Z_INDEX = -1
const MIN_PRINCESS_Z_INDEX = -4000

@onready var princesses = get_tree().get_first_node_in_group("Princesses")

var princesses_on_scene = 0

var all_spawnpoint_positions: Array[Vector2] = []

var _next_princess_z_index = MAX_PRINCESSES_ON_SCENE



func _get_next_random_spawnpoint() -> Vector2:
	return Vector2(randi_range(-400, 400), randi_range(-200, 200))

func _get_next_z_index() -> int:
	_next_princess_z_index -= 1
	if _next_princess_z_index < MIN_PRINCESS_Z_INDEX:
		_next_princess_z_index = MAX_PRINCESS_Z_INDEX
	return _next_princess_z_index


var selected_princess: Princess:
	set(value):
		if value == null:
			if selected_princess != null:
				selected_princess.z_index *= -1
				selected_princess.check_overlapping_princesses()
		
		selected_princess = value
		
		if value != null:
			selected_princess.z_index *= -1


func buy_princess(princess_level: int) -> void:
	if level_costs.princess_level_costs[princess_level] <= CrystalManager.crystals:
		CrystalManager.crystals -= level_costs.princess_level_costs[princess_level]
		emit_signal("princess_bought")
		_spawn_princess(princess_level)
	else:
		emit_signal("not_enough_crystals_to_buy_princess", level_costs.princess_level_costs[princess_level] - CrystalManager.crystals)
		

func spawn_princesses(a: Array) -> void:
	for i in a:
		_spawn_princess(int(i))


func _spawn_princess(princess_level: int) -> void:
	if princesses == null:
		push_error("Узел Princesses не установлен")
		return
	
	if  princesses.get_child_count() >= MAX_PRINCESSES_ON_SCENE:
		print("Достигнут лимит принцесс на сцене")
		return

	var princess_instance = princess_scene.instantiate()
	_initialize_princess(princess_instance, princess_level)	
	emit_signal("princess_spawned", princess_instance)


func _initialize_princess(princess: Princess, level: int) -> void:
	if princess:
		princess.z_index = _get_next_z_index()
		princess.level = level
		princess.position = _get_next_random_spawnpoint()
		princesses.add_child(princess)
		princess.connect("princess_level_increased", _on_princess_level_increased)
	else:
		print("Не удалось создать инстанс принцессы")


func get_princesses_levels_as_array() -> Array:
	var levels = []
	for p in princesses.get_children():
		levels.append(p.level)
	return levels


func _on_princess_level_increased(princess: Princess) -> void:
	emit_signal("princess_level_increased", princess)
