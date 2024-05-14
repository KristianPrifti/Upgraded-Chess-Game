extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_setting_upgrade(icon_path, cooldown, cost, ability_name, ability_description):
	$icon.texture = ResourceLoader.load(icon_path)
	$cooldown.text += cooldown
	$cost.text += cost
	$name.text = ability_name
	$description.text = ability_description
