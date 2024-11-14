extends Label


func _ready() -> void:
	_princess_count_increased()
	PrincessManager.connect("princess_spawned", _princess_count_increased)
	PrincessManager.connect("princess_level_increased", _princess_count_decreased)
	


func _princess_count_increased(_p = null):
	text = str(PrincessManager.princesses.get_child_count())


func _princess_count_decreased(_p = null):
	text = str(PrincessManager.princesses.get_child_count() - 1)
