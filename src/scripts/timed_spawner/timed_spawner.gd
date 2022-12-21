extends Node

const PresentScene = preload("res://factory/factory_presents/present.tscn")

export var spawn_delay = 1.0 \
	setget set_spawn_delay, get_spawn_delay

export(int) \
	var spawn_counter = 10

export(NodePath) \
	var spawn_target_path = NodePath()

func _on_timer_timeout() -> void:
	if spawn_counter <= 0 or not can_spawn_next():
		return
	var spawn_target_node = get_node(spawn_target_path)
	_spawn_scene_at(PresentScene, spawn_target_node)
	Gameplay.add_score()
	spawn_counter -= 1

func _spawn_scene_at(p_scene: PackedScene, p_target: Node) -> void:
		var spawned_node = p_scene.instance()
		var origin = p_target.global_transform.origin
		p_target.add_child(spawned_node)

func set_spawn_delay(p_wait_time: float) -> void:
	$Timer.set_wait_time(p_wait_time)

func get_spawn_delay() -> float:
	return $Timer.get_wait_time()

func can_spawn_next() -> bool:
	for offset in get_parent().get_next_offsets(-1.0):
		if offset < 0.0: return false
	return true

func get_present_counter() -> int:
	return spawn_counter
