extends Control

var board: Array
var turn_player
var cooldown: int
var cost: int

var GRID

#array that holds counters images
var counter_paths = ["res://assets/counters assets/0counter.png", 
"res://assets/counters assets/1counter.png", "res://assets/counters assets/2counter.png",
"res://assets/counters assets/3counter.png", "res://assets/counters assets/4counter.png",
"res://assets/counters assets/5counter.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	#GRID = get_node("../../../%grid")
	# Make sure to call these two on the use_ability method of every ability
	#board = GRID.get_board()
	#turn_player = GRID.get_turn_player()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# set up the instance variables for the child abilities
func setup(cooldwon, cost):
	GRID = get_node("../../../%grid")
	board = GRID.get_board()
	turn_player = GRID.get_turn_player()
	self.cooldown = cooldown
	self.cost = cost
	

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

# check if the ability can be used on the specific chess pieces
# this function takes an array of pieces in case an ability affects mulpiple pieces
func can_be_used(arr: Array) -> bool:
	var count: int
	for x in arr:
		if x.get_node("Sprite2D/counter_img").texture == null:
			count+=1
	
	if count > 0:
		return true
	return false
		
