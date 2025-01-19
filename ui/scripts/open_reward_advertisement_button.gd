extends TextureButton


@onready var advertisement_manager: AdvertisementManager = get_tree().get_nodes_in_group('Advertisement')[0]


func _pressed() -> void:
	advertisement_manager.show_reward_advertisement()
