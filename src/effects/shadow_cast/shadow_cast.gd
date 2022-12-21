extends RayCast

func _physics_process(p_delta: float) -> void:
	$MeshInstance.visible = is_colliding()
	if not is_colliding():
		return
	
	var xform_inv = get_global_transform_interpolated().affine_inverse()
	var point = xform_inv.xform(get_collision_point())
	$MeshInstance.transform.origin.y = point.y + 0.001
