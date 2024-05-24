extends Control

# vars that are used to create abilities
var board: Array
var turn_player
var turn_to_activate: int
var turn
var cooldown: int
var cost: int
var ability_name: String

var GRID

# var used to show possible moves for abilities if necessary
var active_symbol_ability_path = preload("res://active_symbol_ability.tscn")
var hold_ability_positions

# vars that will be used to create activate_ability_window and to add them to the queue
var activate_ability_window_path = preload("res://activate_ability_window.tscn")
var queue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


# set up the instance variables for the child abilities
func setup(cooldown, cost, ability_name):
	self.cooldown = cooldown
	self.cost = cost
	self.ability_name = ability_name
	self.queue = get_node("../../../../abilities_queue_label/ScrollContainer/abilities_queue")
	update_vars()
	

# called by child abilities to get updated variables
func update_vars():
	GRID = get_node("../../../%grid")
	board = GRID.get_board()
	turn_player = GRID.get_turn_player()
	turn = GRID.get_turn()
	hold_ability_positions = GRID.make_2d_array()


func create_ability(icon_texture, cooldown, cost, ability_name, ability_description):
	$icon.texture = icon_texture
	$cooldown.text = "Cooldown: " + str(cooldown)
	$cost.text = "Cost: " + str(cost)
	$name.text = ability_name
	$description.text = ability_description
	# Make sure to have a use_ability() function for every ability you create
	# call the function on that ability's script
	self.set_script(load("res://abilities_scripts/" + ability_name +" Script.gd"))
	self._ready()
	self.setup(cooldown, cost, ability_name)
	
#---------------------------------------------------------------------------------------------------

func add_active_symbol_ability(x, y):
	var symbol = active_symbol_ability_path.instantiate()
	get_node("../../../../").get_node("active_squares").add_child(symbol)
	symbol.position = GRID.grid_to_pixel(x, y)
	hold_ability_positions[x][y] = symbol

func reset_at_end_of_activation():
	get_node("../../../../").get_node("active_squares").remove_circles()
	hold_ability_positions.clear()
	hold_ability_positions = GRID.make_2d_array()
#---------------------------------------------------------------------------------------------------

# chack if the player has enough gems to buy the ability
func has_enough_gems() -> bool:
	turn_player = GRID.get_turn_player()
	var gems
	if turn_player.isWhite:
		gems = GRID.get_white_gems()
	else:
		gems = GRID.get_black_gems()
	
	if gems >= cost:
		return true
	else:
		return false

# check if the ability can be used on the specific chess pieces and returns array 
# with only the ones the ability can be used on
# this function takes an array of pieces in case an ability affects mulpiple pieces
func can_be_used(arr: Array) -> Array:
	var pieces_to_use = []
	if GRID.get_wait_for_promotion() || check_if_any_visibel_in_queue():
		return pieces_to_use
	
	for x in arr:
		if x.get_node("Sprite2D/counter_img").texture == null:
			pieces_to_use.append(x)
			
	return pieces_to_use
		

func check_if_any_visibel_in_queue():
	var q = queue.get_child_count()
	for z in q:
		if queue.get_child(z).visible:
			return true
	return false


func create_activate_ability_window(name: String, owner: bool, ability, pieces: Array):
	GRID.collect_gem(-cost)
	for x in pieces:
		x.set_ability(cooldown)
		x.set_counter()
	var window = activate_ability_window_path.instantiate()
	get_node("../../../../abilities_queue_label/ScrollContainer/abilities_queue").add_child(window)
	window.create_ability(name, owner, ability, pieces)
	

#---------------------------------------------------------------------------------------------------
# to make the abilities creatin look cleaner in abilities files

# function to be called at the beggining of every use_ability() method
# returns true if the player can buy the specific ability at that moment
func can_buy_ability() -> bool:
	if !(GRID.ability_is_doing_something[0]):
		update_vars()
	
		GRID.ability_in_use()
	
		if has_enough_gems():
			GRID.ability_is_doing_something[0] = true
			return true
			
	return false

# function to be called at the end of buying the ability part of the code
# resets the necessary variabels
func end_of_buy_ability():
	GRID.ability_is_doing_something[0] = false

# function that should be called at activate() method
# checks if the ability can be activated
func can_activate(tracker) -> bool:
	if tracker == queue.activation_tracker:
		GRID.ability_is_doing_something[0] = true
		return true
	return false

# call this function at the end of the activation of the ability
# resets the necessary variabels
func end_of_activation():
	reset_at_end_of_activation()
	GRID.ability_is_doing_something[0] = false
	queue.activation_finished[0] = true
