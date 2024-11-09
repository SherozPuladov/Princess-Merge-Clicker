extends Node2D

const MOVE_DURATION: float = 0.03  # Время, за которое принцесса должна достичь цели

var target_position: Vector2

func _input(event: InputEvent) -> void:
	target_position = get_global_mouse_position()

	if event is InputEventScreenDrag:
		if PrincessManager.selected_princess and is_instance_valid(PrincessManager.selected_princess):
			pass
	
	if event is InputEventMouseButton and not event.pressed:
		PrincessManager.selected_princess = null

func _process(delta: float) -> void:
	if PrincessManager.selected_princess and is_instance_valid(PrincessManager.selected_princess):
		var direction = (target_position - PrincessManager.selected_princess.position).normalized()
		var distance = PrincessManager.selected_princess.position.distance_to(target_position)
		var speed = distance / MOVE_DURATION
		var velocity = direction * speed * delta

		# Используем move_and_collide для перемещения принцессы с учетом столкновений
		PrincessManager.selected_princess.move_and_collide(velocity)
