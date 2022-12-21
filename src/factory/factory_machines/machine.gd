extends StaticBody

signal machine_crashed()
signal machine_repaired()

export var enabled = true \
	setget set_enabled, is_enabled 

export(GameplayTypes.Tool) \
	var repair_tool = GameplayTypes.Tool.Wrench

func _ready() -> void:
	$ToolRequired.set_required_tool(repair_tool)
	$ToolRequired.visible = not enabled

func is_enabled() -> bool:
	return enabled

func set_enabled(p_enabled: bool) -> void:
	if enabled == p_enabled:
		return
	enabled = p_enabled
	call_deferred("_update_offset")
	$AlarmLamp.set_alarm(not enabled)

func _update_offset() -> void:
	if is_enabled():
		get_parent().remove_offset(self)
		return
	var origin = global_transform.origin
	var offset = get_parent().get_closest_offset(origin)
	get_parent().set_offset(self, offset)

func _on_interacted(whom, userdata) -> void:
	var can_repair = (repair_tool == Gameplay.get_tool())
	if not is_enabled() and can_repair:
		repair()

func crash() -> void:
	if not is_enabled():
		return
	set_enabled(false)
	emit_signal("machine_crashed")
	$ToolRequired.visible = true

func repair() -> void:
	if is_enabled():
		return
	set_enabled(true)
	emit_signal("machine_repaired")
	$ToolRequired.visible = false
