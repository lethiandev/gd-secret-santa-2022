extends Spatial

var rotate_target = Vector2()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if p_event is InputEventMouseMotion:
		var speed = p_event.relative
		rotate_target += speed * 0.003

func _physics_process(p_delta: float) -> void:
	var rotate_input = Input.get_vector(
		"rotate_xnegative", "rotate_xpositive", "rotate_ynegative", "rotate_ypositive")
	rotate_target += rotate_input * 3.0 * p_delta
	rotate_target.y = clamp(rotate_target.y, -PI/2 + 0.01, PI/2 - 0.01)
	
	var basis = Basis()
	basis = basis.rotated(Vector3.RIGHT, -rotate_target.y)
	basis = basis.rotated(Vector3.UP, -rotate_target.x)
	global_transform.basis = basis
