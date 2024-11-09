extends Node



signal crystals_added(added_crystals: int)
signal crystals_spended(spended_crystals: int)
signal crystals_count_changed(crystals_count: int)

signal crystals_multiplier_increased(increased_to: int)
signal crystals_multiplier_decreased(decreased_to: int)
signal crystals_multiplier_changed(multiplier: int)


signal player_bought_princess(level_of_princess: int)


var is_touch_event_holded: bool = false


var crystals: int = 0:
	set(value):
		if value > crystals:
			emit_signal("crystals_added", value - crystals)
		elif value < crystals:
			emit_signal("crystals_spended", crystals - value)
		emit_signal("crystals_count_changed", value)
		crystals = value


var crystals_multiplier: float = 1:
	set(value):
		if value > crystals_multiplier:
			emit_signal("crystals_multiplier_increased", value - crystals_multiplier)
		elif value < crystals_multiplier:
			emit_signal("crystals_multiplier_decreased", crystals_multiplier - value)
		emit_signal("crystals_multiplier_changed", value)
		crystals_multiplier = value



func add_crystals(count: int = 1):
	crystals += floor(count * crystals_multiplier)


func spend_crystals(count: int = 1):
	crystals -= count


func buy_princess(level: int = 1):
	PrincessManager.spawn_princess(level)


func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.is_released():
		is_touch_event_holded = false
