extends Node


const click_multiplier_data: ClickMultiplier = preload('res://data/upgrades/click_multiplier.tres')

var current_click_multiplier_level: int = 0

func get_current_click_multiplier() -> float:
	if current_click_multiplier_level < click_multiplier_data.multiplies.size():
		return click_multiplier_data.multiplies[current_click_multiplier_level]
	else:
		push_error("Текуший уровень множителья клика больше чем в массиве ClickMultiplierData.Multiplies")
		return 0.0
