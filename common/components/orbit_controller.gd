extends Node
class_name OrbitComponent

@export var orbiter: Node3D
@export var orbit_speed: float = 2.0

var orbit_pivot: Node3D = null
var in_orbit: bool = false 

func _physics_process(delta: float) -> void:
	if in_orbit:
		orbit_pivot.rotate_x(-orbit_speed * delta)
	
func _enter_orbit() -> void:
	# Create a new orbit pivot. 
	orbit_pivot = Node3D.new()
	orbit_pivot.global_transform = Globals.planet_center.global_transform
	Globals.planet_center.add_child(orbit_pivot)
	# Reparent the orbiter to the orbit pivot. 
	orbiter.reparent(orbit_pivot, true)
	in_orbit = true
	
func _exit_orbit() -> void:
	# Reparent the orbiter.
	orbiter.reparent(SpaceshipManager, true)
	# Remove the orbit pivot.
	orbit_pivot.queue_free()
	in_orbit = false 
	
func _input(event: InputEvent) -> void:
	# For debug
	if event.is_action_pressed("orbit_button"):
		_enter_orbit()
