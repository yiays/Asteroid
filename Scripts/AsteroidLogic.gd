extends RigidBody2D

const SIZEFILE = "res://Sprites/asteroid-{def}.png"
const SIZEDEF = {1: "{lv1}", 2: "{lv1}-{lv2}", 3: "--{lv3}"}
const SIZERANGE = {1: 3, 2: 4, 3: 4}

const HITBOXSIZE = {1: 32, 2: 16, 3: 8}

var new_position = null

var size = 0
var design = 0
var quarter = 0
var fragment = 0

var asteroidtemplate = load("res://Scenes/Asteroid.tscn")
onready var spawntarget = self.find_parent("Asteroids")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if size<=1:
		design=round(rand_range(1, SIZERANGE[1]))
	elif size<=2:
		quarter=round(rand_range(1, SIZERANGE[2]))
	else:
		fragment=round(rand_range(1, SIZERANGE[3]))
	
	$Sprite.texture = load(SIZEFILE.format({"def": SIZEDEF[size].format({"lv1": design, "lv2": quarter, "lv3": fragment})}))
	$CollisionShape2D.shape.radius = HITBOXSIZE[size]

func _integrate_forces(state):
	if typeof(new_position) == TYPE_VECTOR2:
		state.transform.origin = new_position
		new_position = null

func on_collision(_collider):
	if size < 3 and spawntarget!=null:
		for i in range(SIZERANGE[size+1]):
			var babyasteroid = asteroidtemplate.instance()
			babyasteroid.position = position.move_toward(Vector2(1,0).rotated(90*i), HITBOXSIZE[size+1])
			babyasteroid.size = size+1
			babyasteroid.design = design
			babyasteroid.quarter = i+1
			babyasteroid.add_central_force(Vector2(10, 0).rotated(90*i))
			babyasteroid.apply_central_impulse(Vector2(HITBOXSIZE[size+1], 0).rotated(90*i))
			spawntarget.add_child(babyasteroid)
	queue_free()
