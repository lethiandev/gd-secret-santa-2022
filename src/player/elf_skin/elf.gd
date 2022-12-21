extends "res://player/player_skin.gd"

var is_walking = false
var is_standing = false

var is_airborne = false
var is_grounded = false

var walk_speed = 0.0
var walk_speed_target = 0.0

func _process(p_delta: float) -> void:
	$AnimationTree['parameters/locomotion/conditions/is_walking'] = is_walking
	$AnimationTree['parameters/locomotion/conditions/is_standing'] = is_standing
	$AnimationTree['parameters/conditions/is_airborne'] = is_airborne
	$AnimationTree['parameters/conditions/is_grounded'] = is_grounded
	
	var speed_blend = min(1.0, max(0.0, walk_speed - 1.0) / 2.0)
	$AnimationTree['parameters/locomotion/walk/walk_run_blend/blend_amount'] = speed_blend
	$AnimationTree['parameters/locomotion/walk/speed/scale'] = walk_speed
	walk_speed = lerp(walk_speed, walk_speed_target, 10.0 * p_delta)

func set_linear_velocity(p_lv: Vector3, p_max_speed: float = 3.0) -> void:
	walk_speed_target = p_lv.length()
	is_walking = walk_speed_target > 0.01
	is_standing = not is_walking

func set_airborne(p_airborne: bool) -> void:
	is_airborne = p_airborne
	is_grounded = not p_airborne
