class_name Princess
extends CharacterBody2D



signal princess_level_increased(p: Princess)



@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var dragging_area: DraggingArea = $DraggingArea
@onready var collision_of_dragging_area: CollisionShape2D = $DraggingArea/CollisionShape2D
@onready var level_label: Label = $LevelLabel

# Части тела
@onready var head_sprite: Sprite2D = $Skeleton/Middle/Torso/Head/Head
@onready var hair_sprite: Sprite2D = $Skeleton/Middle/Torso/Head/Hair
@onready var arm_left_sprite: Sprite2D = $Skeleton/Middle/Torso/ArmLeft/ArmLeft
@onready var arm_right_sprite: Sprite2D = $Skeleton/Middle/Torso/ArmRight/ArmRight
@onready var up_sprite: Sprite2D = $Skeleton/Middle/Torso/Up
@onready var leg_left_sprite: Sprite2D = $Skeleton/Middle/Pelvis/LegLeft/LegLeft
@onready var leg_right_sprite: Sprite2D = $Skeleton/Middle/Pelvis/LegRight/LegRight
@onready var down_sprite: Sprite2D = $Skeleton/Middle/Pelvis/Down
 
# Части одежды
@onready var dress_head_sprite: Sprite2D = $Skeleton/Middle/Torso/Head/DressHead
@onready var dress_arm_left_sprite: Sprite2D = $Skeleton/Middle/Torso/ArmLeft/DressArmLeft
@onready var dress_arm_right_sprite: Sprite2D = $Skeleton/Middle/Torso/ArmRight/DressArmRight
@onready var dress_up_sprite: Sprite2D = $Skeleton/Middle/Torso/DressUp
@onready var dress_leg_left_sprite: Sprite2D = $Skeleton/Middle/Pelvis/LegLeft/DressLegLeft
@onready var dress_leg_right_sprite: Sprite2D = $Skeleton/Middle/Pelvis/LegRight/DressLegRight
@onready var dress_down_sprite: Sprite2D = $Skeleton/Middle/Pelvis/DressDown



var level: int = 0:
	set(value):
		apply_dress(value)
		if level_label:
			level_label.text = str(value + 1)
		level = value


func _ready() -> void:
	level = level # Для инициализации спрайта у принцессы
	apply_body(0)


func apply_body(body_index: int = 0) -> void:
	var body#: Body
	
	if body_index >= 0 and body_index < PrincessManager.bodies.bodies.size():
		body = PrincessManager.bodies.bodies[body_index]
	if body == null:
		push_error("Body c индексом " + str(body_index) + " не определен или пуст")
		if PrincessManager.bodies.default_body != null:
			body = PrincessManager.bodies.default_body
		else:
			push_error("DefaultBody не определен")
			return
	
	if head_sprite:
		head_sprite.texture = body.head
	if hair_sprite:
		hair_sprite.texture = PrincessManager.hairs.get_random_hair()
	if arm_left_sprite:
		arm_left_sprite.texture = body.arm_left
	if arm_right_sprite:
		arm_right_sprite.texture = body.arm_right
	if up_sprite:
		up_sprite.texture = body.up
	if leg_left_sprite:
		leg_left_sprite.texture = body.leg_left
	if leg_right_sprite:
		leg_right_sprite.texture = body.leg_right
	if down_sprite:
		down_sprite.texture = body.down


func apply_dress(dress_index: int = 0) -> void:
	var dress#: Dress
	
	if dress_index >= 0 and dress_index < PrincessManager.dresses.dresses.size():
		dress = PrincessManager.dresses.dresses[dress_index]
	if dress == null:
		push_error('Dress с индексом ' + str(dress_index) + ' не определен или пуст')
		if PrincessManager.dresses.default_dress != null:
			dress = PrincessManager.dresses.default_dress
		else:
			push_error('DefaultDress не определен')
			return
	
	if dress_head_sprite:
		dress_head_sprite.texture = dress.head
	if dress_arm_left_sprite:
		dress_arm_left_sprite.texture = dress.arm_left
	if dress_arm_right_sprite:
		dress_arm_right_sprite.texture = dress.arm_right
	if dress_up_sprite:
		dress_up_sprite.texture = dress.up
	if dress_leg_left_sprite:
		dress_leg_left_sprite.texture = dress.leg_left
	if dress_leg_right_sprite:
		dress_leg_right_sprite.texture = dress.leg_right
	if dress_down_sprite:
		dress_down_sprite.texture = dress.down


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
				emit_signal("princess_level_increased", self)
				return



func kill_self() -> void:
	queue_free()


func play_click_animation() -> void:
	$AnimationPlayer.play("click")
