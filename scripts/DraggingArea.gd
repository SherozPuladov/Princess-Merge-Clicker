class_name DraggingArea
extends Area2D



@onready var princess: Princess = $".."



func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	_handle_screen_drag(event)
	_handle_screen_touch(event)


func _handle_screen_drag(event: InputEvent) -> void:
	if event is InputEventScreenDrag and event is not InputEventScreenTouch:
		if PrincessManager.selected_princess == null:
			PrincessManager.selected_princess = princess


func _handle_screen_touch(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event is not InputEventScreenDrag and event.is_pressed() and not CrystalManager.is_touch_event_holded:
		CrystalManager.add_crystals(PrincessManager.level_crystals.princess_level_crystals[princess.level])
		princess.play_click_animation()
		CrystalManager.is_touch_event_holded = true
