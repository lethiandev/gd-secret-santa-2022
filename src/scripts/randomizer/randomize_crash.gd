extends Node

var repaired_machines = []
var crashed_machines = []

func _ready() -> void:
	for machine_node in get_tree().get_nodes_in_group("machine"):
		_store_machine(machine_node)

func _store_machine(p_machine: Node) -> void:
	_toggle_machine(p_machine, p_machine.enabled)
	p_machine.connect("machine_repaired", self, "_on_machine_repaired", [p_machine])
	p_machine.connect("machine_crashed", self, "_on_machine_crashed", [p_machine])

func _on_machine_repaired(p_machine: Node) -> void:
	_toggle_machine(p_machine, true)

func _on_machine_crashed(p_machine: Node) -> void:
	_toggle_machine(p_machine, false)

func _on_timeout() -> void:
	if repaired_machines.empty():
		return
	repaired_machines.shuffle()
	_toggle_machine(repaired_machines[0], false)

func _toggle_machine(p_machine: Node, p_repaired: bool) -> void:
	if p_repaired and not repaired_machines.has(p_machine):
		repaired_machines.push_back(p_machine)
		crashed_machines.erase(p_machine)
		p_machine.repair()
	if not p_repaired and not crashed_machines.has(p_machine):
		crashed_machines.push_back(p_machine)
		repaired_machines.erase(p_machine)
		p_machine.crash()
