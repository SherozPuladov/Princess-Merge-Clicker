class_name Princess
extends CharacterBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var dragging_area: DraggingArea = $DraggingArea
@onready var collision_of_dragging_area: CollisionShape2D = $DraggingArea/CollisionShape2D


var level: int = 1:
	set(value):
		if PrincessManager.levels.has(value):
			if sprite:
				sprite.texture = PrincessManager.levels[value]
		level = value


func _ready() -> void:
	level = level # Для инициализации спрайта у принцессы


func check_overlapping_princesses() -> void:
	# Получаем список всех тел, пересекающихся с формой столкновения текущей принцессы
	var overlapping_bodies = dragging_area.get_overlapping_areas()
	# Проходим по всем пересекающимся телам
	for body in overlapping_bodies:
		# Проверяем, является ли пересекающееся тело принцессой
		if body is DraggingArea:
			# Проверяем одного ли уровня принцессы
			if body.princess.level == level:
				level += 1
				body.princess.kill_self()
				return
			


func kill_self() -> void:
	queue_free()


func play_click_animation() -> void:
	$AnimationPlayer.play("click")
