extends Spatial

signal tool_taken()
signal tool_dropped()

export(GameplayTypes.Tool) \
	var tool_type = GameplayTypes.Tool.Wrench

var tool_taken = false

func _on_interacted(p_whom: Node, p_userdata) -> void:
	if can_grab_tool():
		take_tool(tool_type)
	elif can_drop_tool():
		take_tool(GameplayTypes.Tool.None)

func can_grab_tool() -> bool:
	return Gameplay.current_tool == GameplayTypes.Tool.None and not tool_taken

func can_drop_tool() -> bool:
	return Gameplay.current_tool == tool_type and tool_taken

func take_tool(p_tool: int) -> void:
	tool_taken = p_tool != GameplayTypes.Tool.None
	Gameplay.set_tool(p_tool)
	if tool_taken:
		emit_signal("tool_taken")
	if not tool_taken:
		emit_signal("tool_dropped")
