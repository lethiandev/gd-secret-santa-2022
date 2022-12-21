extends Area

func interact(p_whom: Node, p_userdata = null) -> void:
	for area in get_overlapping_areas():
		_interact_with(area, p_whom, p_userdata)

func _interact_with(p_area: Area, p_whom: Node, p_userdata = null) -> void:
	if p_area.is_in_group("interactable") and p_area.has_method("interact"):
		p_area.interact(p_whom, p_userdata)
