extends ScrollContainer

var window_path = preload("res://settings_upgrade.tscn")
var a = 1
var VBox = VBoxContainer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(VBox)
	create_all_abilities()
	$"/root/settings_global".visible = false
	$"/root/settings_global".position = Vector2(160, 230)
	$"/root/settings_global".size = Vector2(1600, 750)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	all_is_on()
	

func create_settings_ability(icon_path, cooldown, cost, ability_name, ability_description):
	var window = window_path.instantiate()
	get_child(0).add_child(window)
	window.create_setting_upgrade(icon_path, cooldown, cost, ability_name, ability_description)

func create_all_abilities():
	var all_icon_path = "res://abilities_assets/All.png"
	var all_cooldown = "N/A"
	var all_cost = "N/A"
	var all_description = "USE ALL ABILITIES IN THE GAME."
	create_settings_ability(all_icon_path, all_cooldown, all_cost, "All Abilities", all_description)
	
	var peasants_unite_icon_path = "res://abilities_assets/Peasants_Unite.png"
	var peasants_unite_cooldown = "4"
	var peasants_unite_cost = "2"
	var peasants_unite_description = "All the pawns that can move forward, will move foreward one space."
	create_settings_ability(peasants_unite_icon_path, peasants_unite_cooldown, peasants_unite_cost, "Peasants Unite", peasants_unite_description)
	
	var color_switch_icon_path = "res://abilities_assets/Color_Switch.png"
	var color_switch_cooldown = "2"
	var color_switch_cost = "1"
	var color_switch_description = "Bishop can move to an ajecent space with a different color from the currrent space."
	create_settings_ability(color_switch_icon_path, color_switch_cooldown, color_switch_cost, "Color Switch", color_switch_description)
	
	var early_retirement_icon_path = "res://abilities_assets/Early_Retirement.png"
	var early_retirement_cooldown = "5"
	var early_retirement_cost = "7"
	var early_retirement_description = "Pick one of your pieces. That piece now becomes the king."
	create_settings_ability(early_retirement_icon_path, early_retirement_cooldown, early_retirement_cost, "Early Retirement", early_retirement_description)
	
	var sacrificial_juice_icon_path = "res://abilities_assets/Sacrificial_Juice.png"
	var sacrificial_juice_cooldown = "3"
	var sacrificial_juice_cost = "5"
	var sacrificial_juice_description = "Pick one of your pieces. That piece piece is destroyed and you get gems equal to that piece's value. (pawn = 1, knight/bishop = 3, rook = 5, qween = 9, king = 10)"
	create_settings_ability(sacrificial_juice_icon_path, sacrificial_juice_cooldown, sacrificial_juice_cost, "Sacrificial Juice", sacrificial_juice_description)
	
	var expensive_castling_icon_path = "res://abilities_assets/Expensive_Castling.png"
	var expensive_castling_cooldown = "0"
	var expensive_castling_cost = "5"
	var expensive_castling_description = "Select a king and a rook that are either on the same row or column and castle. If they are next to each other they switch places."
	create_settings_ability(expensive_castling_icon_path, expensive_castling_cooldown, expensive_castling_cost, "Expensive Castling", expensive_castling_description)
	
	var spawn_edible_wall_icon_path = "res://abilities_assets/Spawn Edible Wall.png"
	var spawn_edible_wall_cooldown = "0"
	var spawn_edible_wall_cost = "3"
	var spawn_edible_wall_description = "Spawn a wall piece. It has to be captured if you want to go through it."
	create_settings_ability(spawn_edible_wall_icon_path, spawn_edible_wall_cooldown, spawn_edible_wall_cost, "Spawn Edible Wall", spawn_edible_wall_description)
	
	var spawn_trap_icon_path = "res://abilities_assets/Spawn Trap.png"
	var spawn_trap_cooldown = "0"
	var spawn_trap_cost = "5"
	var spawn_trap_description = "Spawn a trap. The next piece that lands on it is destroyed."
	create_settings_ability(spawn_trap_icon_path, spawn_trap_cooldown, spawn_trap_cost, "Spawn Trap", spawn_trap_description)
	
	var destructive_hammer_icon_path = "res://abilities_assets/Destructive Hammer.png"
	var destructive_hammer_cooldown = "0"
	var destructive_hammer_cost = "7"
	var destructive_hammer_description = "Destroy an item on the board (gem, wall, trap)."
	create_settings_ability(destructive_hammer_icon_path, destructive_hammer_cooldown, destructive_hammer_cost, "Destructive Hammer", destructive_hammer_description)
	
	var disrespect_icon_path = "res://abilities_assets/Disrespect.png"
	var disrespect_cooldown = "0"
	var disrespect_cost = "10"
	var disrespect_description = "Buy and find out."
	create_settings_ability(disrespect_icon_path, disrespect_cooldown, disrespect_cost, "Disrespect", disrespect_description)


# this function makes all other buttons disabled if the "all abilities" button is on
#get_child(0) is used to get the VBox which is the child of the ScrollContainer
func all_is_on():
	var number_of_children = get_child(0).get_child_count()
	var child_number = 1
	if get_child(0).get_child(0).get_node("CheckButton").button_pressed:
		while(child_number < number_of_children):
			get_child(0).get_child(child_number).get_node("CheckButton").disabled = true
			child_number+=1
	else:
		while(child_number < number_of_children):
			get_child(0).get_child(child_number).get_node("CheckButton").disabled = false
			child_number+=1

func get_abilities():
	var number_of_children = get_child(0).get_child_count()
	var children = []
	var child_number = 1
	if is_all_on():
		while child_number < number_of_children:
			children.append(get_child(0).get_child(child_number))
			child_number+=1
	else:
		while child_number < number_of_children:
			if get_child(0).get_child(child_number).get_node("CheckButton").button_pressed:
				children.append(get_child(0).get_child(child_number))
			child_number+=1
	
	return children
	

func is_all_on():
	if get_child(0).get_child(0).get_node("CheckButton").button_pressed:
		return true
	return false

