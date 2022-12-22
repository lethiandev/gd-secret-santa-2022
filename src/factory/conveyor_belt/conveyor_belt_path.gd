extends Path

var offsets = Dictionary()

func add_transport_points_from(p_node: Spatial) -> void:
	var xform_inv = global_transform.affine_inverse()
	var transport_points = p_node.get_transport_points()
	for point in transport_points:
		var local_point = xform_inv.xform(point[0])
		curve.add_point(local_point, point[1], point[2])

func _add_transport_machine(p_node: Spatial) -> void:
	var xform_inv = global_transform.affine_inverse()
	var position = xform_inv.xform(p_node.global_transform.origin)
	var offset = curve.get_closest_offset(position)

func set_offset(p_node: Node, p_offset: float) -> void:
	offsets[p_node] = p_offset

func remove_offset(p_node: Node) -> void:
	offsets.erase(p_node)

func get_next_offsets(p_from: float) -> PoolRealArray:
	var next_offsets = PoolRealArray()
	for node_key in offsets.keys():
		var offset = offsets[node_key]
		if p_from <= offset:
			next_offsets.push_back(offset)
	return next_offsets

func get_closest_offset(p_from: Vector3) -> float:
	var from_local = global_transform.xform_inv(p_from)
	return curve.get_closest_offset(from_local)
