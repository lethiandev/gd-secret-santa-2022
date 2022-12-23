extends Node

func _ready() -> void:
	Gameplay.reset_state()
	Gameplay.connect("presents_changed", self, "_on_presents_changed")

func _exit_tree():
	get_tree().paused = false

func _on_presents_changed(p_counter: int) -> void:
	if p_counter <= 0:
		$GameOver.visible = true
