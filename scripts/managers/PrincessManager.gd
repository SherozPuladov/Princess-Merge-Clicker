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

@onready var princesses = get_tree().get_nodes_in_group("Princesses")[0]

var princesses_on_scene = 0

var all_spawnpoint_positions: Array[Vector2] = []



var _next_random_spawnpoint: Vector2:
	get:
		# Возвращаем случайную позицию из массива
		if all_spawnpoint_positions.size() > 0:
			return all_spawnpoint_positions[randi_range(0, all_spawnpoint_positions.size() - 1)]
		else:
			return Vector2()  # Если массив пустой, возвращаем нулевой вектор


var _next_princess_z_index = MAX_PRINCESS_Z_INDEX:
	get:
		_next_princess_z_index -= 1 # 1 шаг назад что бы все новые принцессы отображались за старыми
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
		


func _spawn_princess(princess_level: int) -> void:
	if princesses == null:
		push_error("Узел Princesses не установлен")
		return
	
	# Проверка того достигло ли принцессы максимального лимита на сцену
	princesses_on_scene = princesses.get_child_count()
	if  princesses_on_scene >= MAX_PRINCESSES_ON_SCENE:
		print("Ошибка: достигнут лимит принцесс на сцене")
		return

	# Создаем инстанс сцены принцессы
	var princess_instance = princess_scene.instantiate()
	
	# Инициализируем принцессу
	_initialize_princess(princess_instance, princess_level)
	
	emit_signal("princess_spawned", princess_instance)


func _initialize_princess(p: Princess, p_level: int):
	# Проверяем, что инстанс успешно создан
	if p != null:
		# Устанавливаем z index для принцессы
		p.z_index = _next_princess_z_index
		var princess = p as Princess
		princess.level = p_level
		# Добавляем инстанс принцессы как дочерний объект к узлу Princesses
		princesses.add_child(p)
		# Коннектим сигнал что бы ретранслировать его
		princess.connect("princess_level_increased", _retranslate_princess_level_increased_signal)
		# Устанавливаем позицию принцессы на случайную позицию
		princess.position = _next_random_spawnpoint
	else:
		print("Не удалось создать инстанс принцессы")


func _retranslate_princess_level_increased_signal(princess: Princess):
	emit_signal("princess_level_increased", princess)
