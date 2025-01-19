extends Resource
class_name Hairs



@export var hairs: Array[CompressedTexture2D]



func get_random_hair() -> CompressedTexture2D:
	if hairs.size() > 0:
		return hairs[randi() % hairs.size()]
	else:
		push_error("Массив Hairs пустой!")
		return null
