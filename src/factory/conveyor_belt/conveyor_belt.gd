extends StaticBody

func _ready() -> void:
	get_parent().add_transport_points_from(self)

func get_transport_points() -> Array:
	var transport_points = Array()
	var path_xform = $TransportPath.global_transform
	var path_curve = $TransportPath.curve
	for i in range(path_curve.get_point_count()):
		var point_world = path_xform.xform(path_curve.get_point_position(i))
		var point_in = path_curve.get_point_in(i)
		var point_out = path_curve.get_point_out(i)
		transport_points.push_back([point_world, point_in, point_out])
	return transport_points
