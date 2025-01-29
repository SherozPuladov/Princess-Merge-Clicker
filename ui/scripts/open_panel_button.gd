extends TextureButton


@export var panel_name: String = "Shop"
@onready var panel: PanelManager = $'../Panel'



func _pressed() -> void:
	panel.show_panel(panel_name)
