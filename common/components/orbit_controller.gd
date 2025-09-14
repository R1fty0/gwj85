extends Node
class_name OrbitController

## Note: This script assuming its parent is the one is should be controlling. 

@export var orbit_axis: Vector3 = Vector3.LEFT
## How high above the planet is the object orbiting. 
@export var orbit_radius: float = 1.0
## How fast does the object move while orbiting. 
@export var orbit_velocity: float = 2.0

# TODO: make getting this cleaner 
@export var planet_center: Node3D
var orbit_angle: float = 0.0


func _physics_process(delta: float) -> void:
	# Update orbit angle
	orbit_angle += orbit_velocity * delta
	var rotation = Basis().rotated(orbit_axis.normalized(), orbit_angle)
	# TODO: fix this so that planet position doesn't have to be at (0,0,0)
	var offset = rotation * Vector3(0,0, orbit_radius)
	var new_pos = offset + planet_center.global_position
	# Get the object's last position. 
	var old_pos = get_parent().global_position
	# Figure out the rotation needed for the object to be pointing at its new position. 
	var direction = (new_pos - old_pos).normalized()
	# Apply the rotation.
	if direction.length() > 0:
		get_parent().look_at(new_pos + direction, orbit_axis)
	# Apply the new position. 
	get_parent().global_position = new_pos
	
