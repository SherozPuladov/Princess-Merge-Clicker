extends Label


var following_princess


func _init() -> void:
	PrincessManager.connect("princess_spawned", _follow_new_princess)


func _process(delta: float) -> void:
	if is_instance_valid(following_princess):
		text = str(following_princess.position)


func _follow_new_princess(princess: Princess):
	following_princess = princess
