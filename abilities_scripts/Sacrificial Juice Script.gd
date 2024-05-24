extends "res://scripts/ability_in_shop.gd"

var being_set_up: bool
var activation_in_progress: bool


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(buy_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if being_set_up:
		finish_buy_ability()


func buy_ability():
	if can_buy_ability():
		being_set_up = true

func finish_buy_ability():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		if GRID.is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] != null && \
		board[grid_position.x][grid_position.y].is_chess_piece && board[grid_position.x][grid_position.y].isWhite == turn_player.isWhite:
			var pieces_to_use = can_be_used([board[grid_position.x][grid_position.y]])
			if pieces_to_use.size() != 0:
				var player_color = pieces_to_use[0].isWhite
				create_activate_ability_window(ability_name, player_color, activate, pieces_to_use)
				
		being_set_up = false
		end_of_buy_ability()

func activate(the_arr):
	var arr = the_arr[1]
	#if tracker == queue.activation_tracker:
	if can_activate(the_arr[0]):
		var piece_to_sacrifice = arr[0]
		var gems_to_gain = 0
		if piece_to_sacrifice.piece_type == "qween":
			gems_to_gain = 9
		elif piece_to_sacrifice.piece_type == "rook":
			gems_to_gain = 5
		elif piece_to_sacrifice.piece_type == "bishop":
			gems_to_gain = 3
		elif piece_to_sacrifice.piece_type == "knight":
			gems_to_gain = 3
		elif piece_to_sacrifice.piece_type == "pawn":
			gems_to_gain = 1
		elif piece_to_sacrifice.piece_type == "king":
			gems_to_gain = 10
		
		GRID.player_collect_gems(gems_to_gain, piece_to_sacrifice.isWhite)
		arr.erase(piece_to_sacrifice)
		
		var vec = GRID.pixel_to_grid(piece_to_sacrifice.position.x, piece_to_sacrifice.position.y)
		board[vec.x][vec.y] = null
		piece_to_sacrifice.queue_free()
		
		#check if there are kings left to continue the game
		var piece_to_sacrifice_isWhite = piece_to_sacrifice.isWhite
		if GRID.kings_are_left(piece_to_sacrifice_isWhite) == false:
			GRID.switch_to_end_scene(piece_to_sacrifice_isWhite)
			
	end_of_activation()

