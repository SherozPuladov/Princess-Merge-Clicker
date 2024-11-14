extends Label


func _ready() -> void:
	CrystalManager.connect("crystals_count_changed", _update_crystals_count)
	_update_crystals_count(0)
	pass


func _update_crystals_count(crystals_count: int):
	text = str(crystals_count)
