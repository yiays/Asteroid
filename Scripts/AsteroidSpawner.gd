extends Node

const MAX_SPAWNS = 4
const ASTEROIDSIZES = {1:32, 2:16, 3:8}
var asteroidtemplate = load("res://Scenes/Asteroid-1.tscn")
var asteroidsize = 1

func _ready():
	spawn(MAX_SPAWNS, asteroidsize, asteroidtemplate)

func spawn(num, size, template):
	var spawned = []
	
	var displaywidth = ProjectSettings.get_setting("display/window/size/width")
	var displayheight = ProjectSettings.get_setting("display/window/size/height")
	var objectsize = ASTEROIDSIZES[size]
	
	randomize()
	
	while len(spawned) < num:
		var randpos = Vector2(round(rand_range(0, displaywidth)), round(rand_range(0, displayheight)))
		if randpos.x > displaywidth-objectsize and randpos.x < displaywidth+objectsize\
		   and randpos.y > displayheight-objectsize and randpos.y < displaywidth+objectsize:
			print_debug("asteroid too close to player!")
			continue
		for asteroid in spawned:
			if randpos.x > asteroid.x-objectsize and randpos.x < asteroid.x+objectsize\
			   and randpos.y > asteroid.y-objectsize and randpos.y < asteroid.y+objectsize:
				print_debug("overlapping asteroid detected!")
				continue
		
		var asteroid = template.instance()
		asteroid.position = randpos
		asteroid.add_central_force(Vector2(10,0).rotated(rand_range(0,360)))
		asteroid.bounce = 1
		self.add_child(asteroid)
		spawned.append(randpos)
