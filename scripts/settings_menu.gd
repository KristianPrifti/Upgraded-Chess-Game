extends VBoxContainer

var window_path = preload("res://settings_upgrade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_all_abilities()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	all_is_on()

func create_settings_ability(icon_path, ability_name, ability_description):
	var window = window_path.instantiate()
	add_child(window)
	window.create_setting_upgrade(icon_path, ability_name, ability_description)

func create_all_abilities():
	var all_icon_path = "res://abilities_assets/All.png"
	var all_description = "USE ALL ABILITIES IN THE GAME."
	create_settings_ability(all_icon_path, "All Abilities", all_description)
	
	var peasants_unite_icon_path = "res://abilities_assets/Peasants_Unite.png"
	var peasants_unite_description = "All the pawns that can move forward, will move foreward one space."
	create_settings_ability(peasants_unite_icon_path, "Peasants Unite", peasants_unite_description)
	
	var color_switch_icon_path = "res://abilities_assets/Color_Switch.png"
	var color_switch_description = "Bishop can move to an ajecent space with a different color from the currrent space."
	create_settings_ability(color_switch_icon_path, "Color Switch", color_switch_description)
	
	var early_retirement_icon_path = "res://abilities_assets/Early_Retirement.png"
	var early_retirement_description = "Pick one of your pieces. That piece now becomes the king."
	create_settings_ability(early_retirement_icon_path, "Early Retirement", early_retirement_description)
	
	var sacrificial_juice_icon_path = "res://abilities_assets/Sacrificial_Juice.png"
	var sacrificial_juice_description = "Pick one of your pieces. That piece piece is destroyed and you get gems equal to that piece's value. (pawn = 1, knight/bishop = 3, rook = 5, qween = 9)"
	create_settings_ability(sacrificial_juice_icon_path, "Sacrificial Juice", sacrificial_juice_description)


# this function makes all other buttons disabled if the "all abilities" button is on
func all_is_on():
	var children = get_child_count()
	var child_number = 1
	if get_child(0).get_node("CheckButton").button_pressed:
		while(child_number < children):
			get_child(child_number).get_node("CheckButton").disabled = true
			child_number+=1
	else:
		while(child_number < children):
			get_child(child_number).get_node("CheckButton").disabled = false
			child_number+=1
