extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_ability(icon_texture, cooldown, ability_name, ability_description):
	$icon.texture = icon_texture
	$cooldown.text = cooldown
	$name.text = ability_name
	$description.text = ability_description
	self.set_script("res://abilities_scripts/" + ability_name +" Script.gd")
