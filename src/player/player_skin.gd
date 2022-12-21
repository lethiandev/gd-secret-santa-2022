extends Spatial

func rotate_towards(p_axis: Vector3, p_weight: float) -> void:
	var angle_target = atan2(p_axis.z, -p_axis.x) - PI/2
	var basis_target = Basis(Vector3.UP, angle_target)
	var basis_next = global_transform.basis.slerp(basis_target, p_weight)
	global_transform.basis = basis_next
