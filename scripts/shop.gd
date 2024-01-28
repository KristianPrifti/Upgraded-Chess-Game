extends ScrollContainer

var upgrade_window_path = preload("res://upgrade_window.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_all_abilities()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_settings_ability(icon_texture, cooldown: String, ability_name: String, ability_description):
	var window = upgrade_window_path.instantiate()
	get_child(0).add_child(window)
	window.create_ability(icon_texture, cooldown, ability_name, ability_description)
	
func create_all_abilities():
	var abilities_list = settings_global.get_abilities()
	var number_of_abilities = abilities_list.size()
	var curr_ability = 0
	if abilities_list[0].get_node("name").text == "All Abilities":
		pass
		
	while curr_ability < number_of_abilities:
		create_settings_ability(abilities_list[curr_ability].get_node("icon").texture, abilities_list[curr_ability].get_node("cooldown").text, abilities_list[curr_ability].get_node("name").text, abilities_list[curr_ability].get_node("description").text)
		curr_ability += 1
