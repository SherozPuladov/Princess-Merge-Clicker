extends Node


# Инициализация
func _ready() -> void:
	# Загрузка сохранения
	_load()
	
	# Инициализация таймера автосохранения
	var timer = Timer.new()
	timer.wait_time = 10.0
	timer.one_shot = false
	timer.connect("timeout", _save)
	add_child(timer)
	timer.start()


# Попытка сохранения
func _save() -> void:
	Bridge.storage.set(['crystals', 'princesses'], [CrystalManager.crystals, PrincessManager.get_princesses_levels_as_array()], _on_storage_set_completed)

# Результат попытки сохранения
func _on_storage_set_completed(success) -> void:
	print("On Storage Set Completed, success: ", success)


# Попытка загрузки
func _load() -> void:
	Bridge.storage.get(['crystals', 'princesses'], _on_storage_get_completed)

# Результат попытки загрузки
func _on_storage_get_completed(success, data) -> void:
	print(data)
	if success:
		if data != null and data.size() >= 2:
			CrystalManager.crystals = int(data[0])
			PrincessManager.spawn_princesses(JSON.parse_string(data[1]))
		else:
			push_error("Data пуста либо не хватает данных")
