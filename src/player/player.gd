extends KinematicBody

const GRAVITY = 30.0

const WALK_ACCELERATION = 1.0
const WALK_DECELERATION = 10.0
const WALK_MAX_SPEED = 3.0

const JUMP_STRENGTH = 5.5
const JUMP_GRAVITY_SCALE = 0.4
const JUMP_COYOTE_DELAY = 0.1
const JUMP_REPEAT_DELAY = 0.1

var linear_velocity = Vector3()
var speed_factor = 0

var is_moving = false
var is_falling = false
var is_jumping = false

var coyote_timer = 0.0
var jumper_timer = 0.0

func _process(p_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		$InteracteeArea.interact(self)

func _physics_process(p_delta: float) -> void:
	var move_input = Input.get_vector(
		"strafe_left", "strafe_right", "move_forward", "move_backward")
	var jump_pressed = Input.is_action_just_pressed("jump")
	var jump_released = Input.is_action_just_released("jump")
	
	is_moving = not move_input.is_equal_approx(Vector2())
	is_falling = linear_velocity.y < 0.0
	
	_apply_input_movement(p_delta, move_input)
	_apply_input_jump(p_delta, jump_pressed, jump_released)
	
	_apply_gravity(p_delta)
	_apply_motion(p_delta)
	
	$Skin.set_linear_velocity(linear_velocity)
	$Skin.set_airborne(coyote_timer < JUMP_COYOTE_DELAY/2)
	
	# Fixes an issue with premature floor snapping
	$CollisionShape2.disabled = linear_velocity.y > 0.0 and coyote_timer < 0

func _apply_input_movement(p_delta: float, p_axis: Vector2) -> void:
	var basis = get_viewport().get_camera().global_transform.basis
	var face_forward = Vector3(basis.z.x, 0.0, basis.z.z).normalized()
	var face_right = Vector3(basis.x.x, 0.0, basis.x.z).normalized()
	
	var motion = (face_forward * p_axis.y) + (face_right * p_axis.x)
	var speed = motion * WALK_MAX_SPEED
	linear_velocity.x = speed.x
	linear_velocity.z = speed.z
	
	if is_moving:
		var motion_norm = motion.normalized()
		$Skin.rotate_towards(motion_norm, 15.0 * p_delta)

func _apply_input_jump(p_delta: float, p_jump_pressed: bool, p_jump_released: bool) -> void:
	coyote_timer = JUMP_COYOTE_DELAY if is_on_floor() else coyote_timer - p_delta
	jumper_timer = JUMP_REPEAT_DELAY if p_jump_pressed else jumper_timer - p_delta
	
	var can_jump = is_on_floor() or coyote_timer > 0.0
	if jumper_timer > 0.0 and is_jumping == false and can_jump:
		linear_velocity.y = JUMP_STRENGTH
		coyote_timer = 0.0
		jumper_timer = 0.0
		is_jumping = true
	if p_jump_released and is_jumping == true:
		is_jumping = false

func _apply_gravity(p_delta: float) -> void:
	var gravity_scale = JUMP_GRAVITY_SCALE if is_jumping and not is_falling else 1.0
	var gravity_accel = Vector3.DOWN * GRAVITY * gravity_scale * p_delta
	linear_velocity += gravity_accel

func _apply_motion(p_delta: float) -> void:
	var should_snap = is_on_floor() and linear_velocity.y < 0
	var snap = get_floor_normal() * -0.1 if should_snap else Vector3()
	linear_velocity = move_and_slide_with_snap(linear_velocity, snap, Vector3.UP)
