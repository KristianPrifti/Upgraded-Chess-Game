extends Control

var board: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	board = get_node("../../../%grid").get_board()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_ability(icon_texture, cooldown, ability_name, ability_description):
	$icon.texture = icon_texture
	$cooldown.text = cooldown
	$name.text = ability_name
	$description.text = ability_description
	# Make sure to have a use_ability() function for every ability you create
	# call the function on that ability's script
	self.set_script(load("res://abilities_scripts/" + ability_name +" Script.gd"))
	self._ready()
	



