extends Node

func _ready() -> void:
	Gameplay.connect("timer_changed", self, "_on_timer_changed")
	Gameplay.connect("presents_changed", self, "_on_presents_changed")

func _on_timer_changed(p_seconds: int) -> void:
	get_node('%Timer').set_time(p_seconds)

func _on_presents_changed(p_left: int) -> void:
	get_node('%Counter').set_counter(p_left)
