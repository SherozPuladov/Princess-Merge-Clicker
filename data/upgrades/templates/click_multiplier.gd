extends Resource
class_name ClickMultiplier



signal current_level_increased(current_level: int)
signal current_level_decreased(current_level: int)



@export var prices: Array[int]
@export var multiplies: Array[float]
@export var current_level: int = 0



func get_current_price() -> int:
	if current_level < prices.size():
		return prices[current_level]
	else:
		push_error("Размер массива 'ClickMultiplier.Prices' меньше чем ", current_level)
		return 0


func get_current_multiply() -> float:
	if current_level < multiplies.size():
		return multiplies[current_level]
	else:
		push_error("Размер массива 'ClickMultiplier.Multiplies'  меньше чем ", current_level)
		return 0.0


func increase_level() -> void:
	current_level += 1
	emit_signal('current_level_increased', current_level)


func decrease_level() -> void:
	current_level -= 1
	emit_signal('current_level_decreased', current_level)
