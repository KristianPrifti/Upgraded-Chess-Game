extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# remove the childern aka the circle that represent active square
func remove_circles():
	if self.get_child_count() > 0:
		var children = self.get_children()
		for c in children:
			self.remove_child(c)
			c.queue_free()
