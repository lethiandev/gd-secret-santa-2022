extends Area

signal interacted(whom, userdata)

func interact(p_whom: Node, p_userdata = null) -> void:
	emit_signal("interacted", p_whom, p_userdata)
