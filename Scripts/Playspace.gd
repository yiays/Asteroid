extends Area2D

const MARGIN = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Playspace_body_exited(body):
	var displaywidth = ProjectSettings.get_setting("display/window/size/width")
	var displayheight = ProjectSettings.get_setting("display/window/size/height")
	#var objectsize = body.shape_owner_get_shape(0,0).extents.x + body.shape_owner_get_shape(0,0).extents.y
	
	var newpos = Vector2(body.position.x,body.position.y)
	if body.position.x <= 0:
		newpos.x = displaywidth + MARGIN
	elif body.position.x >= displaywidth:
		newpos.x = -MARGIN*1.5
	if body.position.y <= 0:
		newpos.y = displayheight + MARGIN
	elif body.position.y >= displayheight:
		newpos.y = -MARGIN
	body.new_position = newpos
