extends KinematicBody2D

const MOTION_MULT = 250
const TURNING_RATIO = 0.7
var acceleration = 0.0
var new_position = null

func _ready():
	pass # Replace with function body.

func _process(_delta):
	self.find_parent("Node2D").find_node("DebugText").text = str("x: ",round(position.x),"\ny: ",round(position.y),"\nspeed: ",acceleration, "\ncollisions: ", get_slide_count())

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		rotation -= delta*5*TURNING_RATIO
	if Input.is_action_pressed("ui_right"):
		rotation += delta*5*TURNING_RATIO
	if Input.is_action_pressed("ui_up"):
		acceleration+=delta+clamp(acceleration/4,0,1)
		$AnimatedSprite.frame = 1
	else: $AnimatedSprite.frame = 0
	if Input.is_action_pressed("ui_down"):
		acceleration-=2
	
	if typeof(new_position) == TYPE_VECTOR2:
		position = new_position
		new_position = null
	
	acceleration = clamp(acceleration, 0, MOTION_MULT)
	move_and_slide(Vector2(0, -acceleration).rotated(rotation), Vector2.ZERO, false, 4, PI/4, false)
	
	for i in get_slide_count():
		var col = get_slide_collision(i)
		
		col.collider.apply_central_impulse(-col.normal * acceleration / 5)
		
		if col.collider.has_method("on_collision"):
			col.collider.on_collision(self)
		else:
			print_debug("Collided with object that doesn't have a collision handler!")
