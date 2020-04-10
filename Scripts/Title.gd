extends Container

var gamestarta = 0.0
var gamestart
var gamestartstate = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	gamestart = self.find_node("GameStartString")

func _input(event):
	if event is InputEventKey and event.pressed:
		self.get_parent().remove_child(self)

func _process(delta):
	if gamestartstate == 0:
		if gamestarta < 1:
			gamestarta += delta/2
			gamestart.set("custom_colors/font_color", Color(1,1,1,gamestarta))
		else:gamestartstate = 1
	elif gamestartstate == 1:
		if gamestarta >0.5:
			gamestarta -= delta/2
			gamestart.set("custom_colors/font_color", Color(1,1,1,gamestarta))
		else: gamestartstate = 0
