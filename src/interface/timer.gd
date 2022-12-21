extends HBoxContainer

func set_time(p_seconds: int) -> void:
	var seconds = p_seconds % 60
	var minutes = int(p_seconds / 60)
	$TimeLabel.set_text("%02d:%02d" % [minutes, seconds])
