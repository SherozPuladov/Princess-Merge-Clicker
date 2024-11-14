class_name DebugManager
extends Node


@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var debug_label: Label = $CanvasLayer/DebugLabel


var is_debugging: bool = true


func _ready() -> void:
	if is_debugging:
		canvas_layer.visible = true
	else:
		canvas_layer.visible = false


func print_debug_text_on_screen(text: String) -> void:
	debug_label.text = text
