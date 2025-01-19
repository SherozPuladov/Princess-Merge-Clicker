extends TextureButton

@onready var panel_manager: PanelManager = $'..'


func _pressed() -> void:
	panel_manager.hide_panel()
