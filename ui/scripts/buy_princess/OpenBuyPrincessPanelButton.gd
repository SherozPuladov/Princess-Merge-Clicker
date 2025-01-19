extends TextureButton

@export var buy_princess_panel_name: String = "Shop"


#@onready var buy_princess_panel: BuyPrincessPanel = $"../BuyPrincessPanel"
@onready var panel: PanelManager = $'../Panel'



func _pressed() -> void:
	panel.show_panel(buy_princess_panel_name)


func appear() -> void:
	visible = true


func disappear() -> void:
	visible = false
