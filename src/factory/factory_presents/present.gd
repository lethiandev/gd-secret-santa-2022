extends PathFollow

func _physics_process(p_delta: float) -> void:
	_update_offset(offset + p_delta)
	get_parent().set_offset(self, offset - 0.5)
	if unit_offset >= 1.0:
		get_parent().remove_offset(self)
		Gameplay.add_score()
		queue_free()

func _update_offset(p_end: float) -> void:
	for next_offset in get_parent().get_next_offsets(offset):
		if not _can_offset_progress(p_end, next_offset):
			offset = next_offset
			return
	offset = p_end

func _can_offset_progress(p_end: float, p_offset: float) -> bool:
	return (offset > p_offset) or (p_end < p_offset)
