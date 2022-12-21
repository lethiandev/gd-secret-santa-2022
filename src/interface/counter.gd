extends HBoxContainer

func set_counter(p_counter: int) -> void:
	$CounterLabel.set_text(str(p_counter))
