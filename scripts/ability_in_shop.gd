extends Control

var board: Array
var turn_player

#array that holds counters images
var counter_paths = ["res://assets/counters assets/0counter.png", 
"res://assets/counters assets/1counter.png", "res://assets/counters assets/2counter.png",
"res://assets/counters assets/3counter.png", "res://assets/counters assets/4counter.png",
"res://assets/counters assets/5counter.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Make sure to call these two on the use_ability method of every ability
	board = get_node("../../../%grid").get_board()
	turn_player = get_node("../../../%grid").get_turn_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func create_ability(icon_texture, cooldown, cost, ability_name, ability_description):
	$icon.texture = icon_texture
	$cooldown.text = cooldown
	$cost.text = cost
	$name.text = ability_name
	$description.text = ability_description
	# Make sure to have a use_ability() function for every ability you create
	# call the function on that ability's script
	self.set_script(load("res://abilities_scripts/" + ability_name +" Script.gd"))
	self._ready()
	



