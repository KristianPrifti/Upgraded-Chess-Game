extends VBoxContainer

# keeps track of when an activation has started and finished so you can't start another one
# without the first being finished
@export var activation_started = [false]
@export var activation_finished = [false]
@export var activation_tracker: Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
