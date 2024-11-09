extends Node2D


func _ready():
	# Заполняем массив позиций дочерних узлов
	store_all_spawnpoint_positions()

func store_all_spawnpoint_positions():
	# Очистим массив перед заполнением
	PrincessManager.all_spawnpoint_positions.clear()
	
	# Проходим по всем дочерним узлам
	for child in get_children():
		# Проверяем, что это Node2D, чтобы иметь доступ к позиции
		if child is Node2D:
			# Добавляем позицию дочернего узла в массив
			PrincessManager.all_spawnpoint_positions.append(child.position)
