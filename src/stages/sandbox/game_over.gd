extends Control

func _ready():
	connect("visibility_changed", self, "_on_visibility_changed")

func _on_visibility_changed() -> void:
	get_tree().paused = visible
	if visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false

func _on_back_pressed():
	get_tree().change_scene("res://stages/menu/menu_stage.tscn")
