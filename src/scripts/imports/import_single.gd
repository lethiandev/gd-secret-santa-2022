tool
extends EditorScenePostImport

func post_import(p_scene: Object) -> Object:
	if p_scene is Node:
		var child = p_scene.get_child(0)
		_reset_transform(child)
		return child
	return p_scene

func _reset_transform(p_node: Node) -> void:
	if p_node is Spatial:
		p_node.transform = Transform()
