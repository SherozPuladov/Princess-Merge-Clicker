extends TextureButton



signal spawn_princess_button_pressed(princess_level: int)



@export var princess_level: int = 0


@onready var name_label: Label = $PrincessNameLabel
@onready var cost_label: Label = $PrincessCostLabel
@onready var princess_texture_rect: TextureRect = $CenterContainer/PrincessTextureRect



func _ready() -> void:
	if princess_level < PrincessManager.level_names.princess_level_names.size():
		name_label.text = tr(PrincessManager.level_names.princess_level_names[princess_level])
	else:
		push_error('PrincessManager.LevelNames с индексом ' + str(princess_level) + ' не определен или пуст')
		name_label.text = tr(PrincessManager.level_names.default_level_name)

	if princess_level < PrincessManager.level_costs.princess_level_costs.size():
		cost_label.text = str(PrincessManager.level_costs.princess_level_costs[princess_level])
	else:
		push_error('PrincessManager.LevelCosts с индексом ' + str(princess_level) + ' не определен или пуст')
		cost_label.text = str(PrincessManager.level_costs.default_level_cost)
	
	if princess_level < PrincessManager.button_textures.textures.size():
		princess_texture_rect.texture = PrincessManager.button_textures.textures[princess_level]
	else:
		push_error('PrincessManager.ButtonTextures с индексом ' + str(princess_level) + ' не определен или пуст')
		princess_texture_rect.texture = PrincessManager.button_textures.default_button_texture


func _pressed() -> void:
	PrincessManager.buy_princess(princess_level)
	emit_signal("spawn_princess_button_pressed", princess_level)
