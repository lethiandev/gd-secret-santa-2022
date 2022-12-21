extends Node

signal timer_changed(seconds)
signal presents_changed(counter)

signal tool_changed(tool_type)

var current_tool = GameplayTypes.Tool.None \
	setget set_tool, get_tool

var presents_max = 0
var presents_counter = 0

var timer_seconds = 0

func reset_state() -> void:
	current_tool = GameplayTypes.Tool.None
	timer_seconds = 0
	restart_present_counter()
	emit_signal("timer_changed", timer_seconds)
	emit_signal("presents_changed", presents_max)
	$Timer.start()

func set_tool(p_tool: int) -> void:
	current_tool = p_tool
	emit_signal("tool_changed", current_tool)

func get_tool() -> int:
	return current_tool

func restart_present_counter() -> void:
	presents_max = 0
	presents_counter = 0
	for spawner in get_tree().get_nodes_in_group("spawner"):
		presents_max += spawner.get_present_counter()

func add_score() -> void:
	presents_counter += 1
	var change = max(0, presents_max - presents_counter)
	emit_signal("presents_changed", change)

func _on_timeout() -> void:
	timer_seconds += 1
	emit_signal("timer_changed", timer_seconds)
