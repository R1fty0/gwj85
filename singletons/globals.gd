extends Node


var planet_center: Node3D

func _ready() -> void:
	planet_center = get_tree().get_first_node_in_group("planet_center")
	if planet_center == null:
		push_error("No planet center in this scene!")
