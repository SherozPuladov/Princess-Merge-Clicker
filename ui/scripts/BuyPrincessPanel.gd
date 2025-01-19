class_name BuyPrincessPanel
extends Control



@onready var close_button = $"../CloseBuyPrincessPanelButton"
@onready var open_button = $"../OpenBuyPrincessPanelButton"

var hide_position: Vector2
var show_position: Vector2

const DURATION: float = 0.3

var is_shown: bool = false



func _ready() -> void:
	GameManager.connect("switch_buy_princess_panel_visibility", switch_visibility)
	show_position.x = global_position.x - size.x - 60
	show_position.y = global_position.y
	hide_position = global_position


func switch_visibility() -> void:
	if is_shown:
		hide_panel()
	else:
		show_panel()


func show_panel() -> void:
	if position.x != hide_position.x:
		position.x = hide_position.x
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position:x", show_position.x, DURATION).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	is_shown = true
	open_button.disappear()
	close_button.appear()


func hide_panel() -> void:
	if position.x != show_position.x:
		position.x = show_position.x
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position:x", hide_position.x, DURATION).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
	is_shown = false
	open_button.appear()
	close_button.disappear()
