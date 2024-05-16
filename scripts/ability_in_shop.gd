extends Control

static var board: Array
var turn_player
var turn_to_activate: int
var turn
var cooldown: int
var cost: int

static var GRID

#array that holds counters images
var counter_paths = ["res://assets/counters assets/0counter.png", 
"res://assets/counters assets/1counter.png", "res://assets/counters assets/2counter.png",
"res://assets/counters assets/3counter.png", "res://assets/counters assets/4counter.png",
"res://assets/counters assets/5counter.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	


# set up the instance variables for the child abilities
func setup(cooldown, cost):
	self.cooldown = cooldown
	self.cost = cost
	update_vars()
	

# called by child abilities to get updated variables
func update_vars():
	GRID = get_node("../../../%grid")
	board = GRID.get_board()
	turn_player = GRID.get_turn_player()
	turn = GRID.get_turn()


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
	self.setup(cooldown, cost)
	

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
	if (GRID.get_wait_for_promotion()):
		return pieces_to_use
	
	for x in arr:
		if x.get_node("Sprite2D/counter_img").texture == null:
			pieces_to_use.append(x)
			
	return pieces_to_use
		

func set_texture(arr: Array):
	for x in arr:
		var counter_to_use = turn - turn_to_activate
		if counter_to_use < 0:
			x.get_node("Sprite2D/counter_img").texture = null
			x.ability_in_progress = false
		else:
			x.get_node("Sprite2D/counter_img").texture = ResourceLoader.load(counter_paths[counter_to_use])
			x.ability_in_progress = true

func update_texture():
	var arr = []
	for i in GRID.get_num_rows():
		for j in GRID.get_num_colums():
			if board[i][j] != null && board[i][j].is_chess_piece && board[i][j].ability_in_progress:
				arr.append(board[i][j])
	set_texture(arr)
