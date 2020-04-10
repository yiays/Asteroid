extends RigidBody2D

var new_position = null

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$AnimatedSprite.frame = rand_range(0, $AnimatedSprite.frames.get_frame_count("default"))

func _integrate_forces(state):
	if typeof(new_position) == TYPE_VECTOR2:
		state.transform.origin = new_position
		new_position = null

func on_collision(_collider):
	print_debug("Hit!")
