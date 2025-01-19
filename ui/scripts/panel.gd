extends Control
class_name PanelManager



func _ready() -> void:
	PrincessManager.connect("princess_bought", hide_panel)
	hide_panel()


func hide_panel() -> void:
	visible = false


func show_panel(panel_name: String) -> void:
	visible = true
	var childs = get_children()
	for child in childs:
		match child.name:
			"Background":
				child.visible = true
			"Name":
				child.visible = true
			"Close":
				child.visible = true
			panel_name:
				child.visible = true
			_:
				child.visible = false
