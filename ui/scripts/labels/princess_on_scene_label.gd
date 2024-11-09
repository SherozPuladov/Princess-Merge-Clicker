extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_princess_count_increased()
	PrincessManager.connect("princess_spawned", _princess_count_increased)
	PrincessManager.connect("princess_level_increased", _princess_count_decreased)
	


func _princess_count_increased(_p = null):
	text = str(PrincessManager.princesses.get_child_count()) + "/" + str(PrincessManager.MAX_PRINCESSES_ON_SCENE)


func _princess_count_decreased(_p = null):
	text = str(PrincessManager.princesses.get_child_count() - 1) + "/" + str(PrincessManager.MAX_PRINCESSES_ON_SCENE)


#func _process(_delta: float) -> void:
	#_update_text()
