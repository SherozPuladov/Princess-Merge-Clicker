extends TextureButton



@onready var buy_princess_panel: BuyPrincessPanel = $"../BuyPrincessPanel"



func _pressed() -> void:
	buy_princess_panel.show_panel()


func appear() -> void:
	visible = true


func disappear() -> void:
	visible = false
