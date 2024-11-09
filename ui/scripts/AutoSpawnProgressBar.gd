extends TextureProgressBar



@onready var auto_spawn: Timer = get_tree().get_nodes_in_group("AutoSpawn")[0]

var duration: float



func _ready() -> void:
	duration = auto_spawn.wait_time
	restart_animation()


func start_animation() -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", 100, duration)
	tween.connect("finished", restart_animation)


func restart_animation():
	value = 0
	start_animation()
