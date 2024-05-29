extends Node2D

@export var isWhite: bool
@export var piece_type: String
# var is_chess_piece checks if the piece is a regular chess piece (can move, capture and those kind of things)
@export var is_chess_piece: bool
# var pass_through is to check if a piece can pass through this object or it cannot move further
@export var pass_through: bool
# keeps track if an ability was used in this piece and it's waiting for the turn to be activated
@export var ability_in_progress: bool
# keeps track of what turn ability should be activated and what the ability is
@export var activate_turn: int


#array that holds counters images
var counter_paths = ["res://assets/counters assets/0counter.png", 
"res://assets/counters assets/1counter.png", "res://assets/counters assets/2counter.png",
"res://assets/counters assets/3counter.png", "res://assets/counters assets/4counter.png",
"res://assets/counters assets/5counter.png"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initial_texture(white_path, black_path):
	if self.isWhite == true:
		$Sprite2D.texture = ResourceLoader.load(white_path)
	elif self.isWhite == false:
		$Sprite2D.texture = ResourceLoader.load(black_path)

func is_in_grid(position: Vector2):
	if position.x >= 0 && position.x < 8 && position.y >=0 && position.y < 8:
		return true
	return false
	
# check if the square is null or a gem
func possible_square(x, y, board):
	#if board[x][y] == null || board[x][y].piece_type == "gem":
	if board[x][y] == null || !board[x][y].is_chess_piece:
		return true

# functions to update counters
func set_counter():
	self.get_node("Sprite2D/counter_img").texture = ResourceLoader.load(counter_paths[activate_turn])
	ability_in_progress = true

func update_counter():
	activate_turn-=1
	if activate_turn < 0:
		self.get_node("Sprite2D/counter_img").texture = null
		ability_in_progress = false
	else:
		self.get_node("Sprite2D/counter_img").texture = ResourceLoader.load(counter_paths[activate_turn])
		ability_in_progress = true

func erase_counter():
	self.get_node("Sprite2D/counter_img").texture = null
	self.get_node("Sprite2D/counter_img/what_ability_is_active").set_tooltip_text("")
	ability_in_progress = false

func get_activate_turn():
	return activate_turn

func set_ability(cooldown):
	ability_in_progress = true
	activate_turn = cooldown
