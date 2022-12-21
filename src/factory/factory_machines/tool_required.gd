extends Spatial

func set_required_tool(p_tool: int) -> void:
	$WrenchMesh.visible = false
	$HammerMesh.visible = false
	if p_tool == GameplayTypes.Tool.Wrench:
		$WrenchMesh.visible = true
	if p_tool == GameplayTypes.Tool.Hammer:
		$HammerMesh.visible = true
