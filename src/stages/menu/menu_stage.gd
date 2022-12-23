extends Control

func _ready():
	if OS.has_feature('HTML5'):
		$VBoxContainer/ButtonQuit.visible = false

func _enter_tree():
	Interface.hide()

func _exit_tree():
	Interface.show()

func _on_start_pressed():
	get_tree().change_scene("res://stages/sandbox/sandbox_stage.tscn")

func _on_full_screen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed

func _on_quit_pressed():
	get_tree().quit()
