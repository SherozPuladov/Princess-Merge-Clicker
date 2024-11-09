extends TextureButton



signal spawn_princess_button_pressed(princess_level: int)


@export var princess_level: int = 1


var princess_scene = "res://scenes/objects/Princess.tscn"


@onready var label: Label = $Label


func _ready() -> void:
	label.text = str(princess_level) + "lv" + " = " + str(PrincessManager.prices[princess_level]) + "c"


func _pressed() -> void:
	PrincessManager.buy_princess(princess_level)
	emit_signal("spawn_princess_button_pressed", princess_level)
