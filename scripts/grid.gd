extends Node2D
# column & row variabels
var num_colums: int = 8
var num_rows: int = 8
var x_start = 50
var y_start = 50
var offset = 100

# array that will become a 2D array
var board = []
var hold_moves = []
# list of paths to pices objects
var pieces_list = [
	preload("res://pieces/rook.tscn"),
	preload("res://pieces/knight.tscn"), 
	preload("res://pieces/bishop.tscn"), 
	preload("res://pieces/qween.tscn"), 
	preload("res://pieces/king.tscn"), 
	preload("res://pieces/pawn.tscn"), 
]

var active_symbol_path = preload("res://active_symbol.tscn")

#var player_path = preload("res://player.tscn")

# mouse click variabels
var click1 = Vector2(0 ,0)
var click2 = Vector2(0, 0)
var controlling: bool = false
var controlling_piece

# player and turn counter
var turn_player
@onready var turn_node = $turn
var turn: int = 0

# check if king is deleated to switch to game over screen
var king_deleated = false
var king_deleated_isWhite
var promote_pawn: bool = false
var promote_pawn_color: bool
var promote_pawn_location: Vector2
# this is so you wait for promotion
var wait_for_promotion: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	board = make_2d_array()
	hold_moves = make_2d_array()
	spawn_initial_pices()
	next_turn()
	get_turn_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var is_controlling = click_input()
	click_output()
	if is_controlling:
		controlling = true
	
	if king_deleated:
		if kings_are_left(king_deleated_isWhite) == false:
			switch_to_end_scene(king_deleated_isWhite)
			king_deleated = false
	
	get_turn_player()

func _input(event: InputEvent) -> void:
	# promote pawn if you have to
	if promote_pawn:
		var piece
		if Input.is_action_just_pressed("ui_r"):
			piece = spawn_initial(pieces_list[0], promote_pawn_color, promote_pawn_location.x, promote_pawn_location.y)
			complete_promotion(piece)
		if Input.is_action_just_pressed("ui_k"):
			piece = spawn_initial(pieces_list[1], promote_pawn_color, promote_pawn_location.x, promote_pawn_location.y)
			complete_promotion(piece)
		if Input.is_action_just_pressed("ui_b"):
			piece = spawn_initial(pieces_list[2], promote_pawn_color, promote_pawn_location.x, promote_pawn_location.y)
			complete_promotion(piece)
		if Input.is_action_just_pressed("ui_q"):
			piece = spawn_initial(pieces_list[3], promote_pawn_color, promote_pawn_location.x, promote_pawn_location.y)
			complete_promotion(piece)
		
# this function is for the promotion so the 4 lines below were not copy pasted a lot
func complete_promotion(piece):
	board[promote_pawn_location.x][promote_pawn_location.y].queue_free()
	add_to_board(piece)
	promote_pawn = false
	wait_for_promotion = false

# makes the array into a 2D array
func make_2d_array():
	var array = []
	for i in num_colums:
		array.append([])
		for j in num_rows:
			array[i].append(null)
	return array

# update turn
func next_turn():
	turn = turn + 1
	turn_node.text = "Turn: " + str(turn)

# get turn player
func get_turn_player():
	if turn % 2 == 1:
		turn_player = $white_player
	elif turn % 2 == 0:
		turn_player = $black_player

# change the column and raw number to pixel values 
func grid_to_pixel(column, row):
	var pixel_x = x_start + offset * column
	var pixel_y = y_start + offset * row
	return Vector2(pixel_x, pixel_y)

# change the column and raw number to grid values 
func pixel_to_grid(pixel_column, pixel_row):
	var row_x = round((pixel_column - x_start) / offset)
	var row_y = round((pixel_row - y_start) / offset)
	return Vector2(row_x, row_y)

# check if mouse cordinates are inside the grid
func is_in_grid(x, y):
	if x >= 0 && x < num_colums && y >= 0 && y < num_rows:
		return true
	return false

func click_input():
	if Input.is_action_just_pressed("ui_click") && controlling == false && wait_for_promotion == false:
		click1 = get_local_mouse_position()
		var grid_position = pixel_to_grid(click1.x, click1.y)
		if is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] != null && \
		board[grid_position.x][grid_position.y].isWhite == turn_player.isWhite:
			controlling_piece = board[grid_position.x][grid_position.y]
			
			var moves = controlling_piece.get_possible_moves(grid_position, board, turn_player.isWhite)
			for i in moves:
				add_active_symbol(i.x, i.y)
			return true

func click_output():
	if Input.is_action_just_pressed("ui_click") && controlling && wait_for_promotion == false:
		click2 = get_local_mouse_position()
		var grid_position = pixel_to_grid(click2.x, click2.y)
		if is_in_grid(grid_position.x, grid_position.y):
			if hold_moves[grid_position.x][grid_position.y] != null:
				var original_grid = pixel_to_grid(click1.x, click1.y)
				move_piece(original_grid.x, original_grid.y, grid_position.x, grid_position.y)
			
			controlling = false
			controlling_piece = null
			# update the active_squares and hold_moves
			get_node("../../").get_node("active_squares").remove_circles()
			hold_moves.clear()
			hold_moves = make_2d_array()

func move_piece(column0, row0, column1, row1):
	# this if statemnt checks if the player clicked twice in a row in the same spot
	if column0 != column1 || row0 != row1:
		if board[column1][row1] != null && board[column0][row0].isWhite == board[column1][row1].isWhite:
			return
		var piece = board[column0][row0]
		if board[column1][row1] != null:
			var deleated_type = board[column1][row1].piece_type
			var deleated_isWhite = board[column1][row1].isWhite
			board[column1][row1].queue_free()
			# if a king was deleated 
			if deleated_type == "king":
				king_deleated = true
				king_deleated_isWhite = deleated_isWhite
		
		board[column0][row0].position = grid_to_pixel(column1, row1)
		board[column0][row0] = null
		board[column1][row1] = piece
		
		# if the piece being moved is a pawn check if it needs to be promoted
		if board[column1][row1].piece_type == "pawn":
			if board[column1][row1].check_for_promotion(board[column1][row1].isWhite, row1):
				promote_pawn = true
				promote_pawn_color = board[column1][row1].isWhite
				promote_pawn_location = Vector2(column1, row1)
				wait_for_promotion = true;
		
		next_turn()
		get_turn_player()

# check if there are any more kings of the deleated color 
func kings_are_left(color):
	for i in 8:
		for j in 8:
			if board[i][j] != null:
				if board[i][j].piece_type == "king" && board[i][j].isWhite == color:
					return true
	return false

# if a player doesn't have any more kings they lose
func switch_to_end_scene(color):
	get_tree().change_scene_to_file("res://end_scene.tscn")

# add the circle active symbol for the active piece
func add_active_symbol(x, y):
	var symbol = active_symbol_path.instantiate()
	get_node("../../").get_node("active_squares").add_child(symbol)
	symbol.position = grid_to_pixel(x, y)
	hold_moves[x][y] = symbol


# spawn pices on their inital position
func spawn_initial_pices():
	var rook = pieces_list[0]
	var knight = pieces_list[1]
	var bishop = pieces_list[2]
	var qween = pieces_list[3]
	var king = pieces_list[4]
	var pawn = pieces_list[5]
	
	# add pawns
	for i in num_colums:
		# create pices & set color & add them as childern to the grid
		# add white pawns to 7nd row & add black pawns to 2th row
		var white_pawn = spawn_initial(pawn, true, i, 6)
		var black_pawn = spawn_initial(pawn, false, i, 1)
		# save them on board 2D array
		add_to_board(white_pawn)
		add_to_board(black_pawn)
	
	# add other pices that are not pawns
	var white_rook = spawn_initial(rook, true, 0, 7)
	var black_rook = spawn_initial(rook, false, 0, 0)
	var white_knight = spawn_initial(knight, true, 1, 7)
	var black_knight = spawn_initial(knight, false, 1, 0)
	var white_bishop = spawn_initial(bishop, true, 2, 7)
	var black_bishop = spawn_initial(bishop, false, 2, 0)
	var white_qween = spawn_initial(qween, true, 3, 7)
	var black_qween = spawn_initial(qween, false, 3, 0)
	var white_king = spawn_initial(king, true, 4, 7)
	var black_king = spawn_initial(king, false, 4, 0)
	add_to_board(white_rook)
	add_to_board(black_rook)
	add_to_board(white_knight)
	add_to_board(black_knight)
	add_to_board(white_bishop)
	add_to_board(black_bishop)
	add_to_board(white_qween)
	add_to_board(black_qween)
	add_to_board(white_king)
	add_to_board(black_king)
	
	var white_rook2 = spawn_initial(rook, true, 7, 7)
	var black_rook2 = spawn_initial(rook, false, 7, 0)
	var white_knight2 = spawn_initial(knight, true, 6, 7)
	var black_knight2 = spawn_initial(knight, false, 6, 0)
	var white_bishop2 = spawn_initial(bishop, true, 5, 7)
	var black_bishop2 = spawn_initial(bishop, false, 5, 0)
	add_to_board(white_rook2)
	add_to_board(black_rook2)
	add_to_board(white_knight2)
	add_to_board(black_knight2)
	add_to_board(white_bishop2)
	add_to_board(black_bishop2)
	

# create pices + set color + add them as childern to the grid + change the position
func spawn_initial(path, isWhite: bool, x, y):
	var piece_path = path
	var piece = piece_path.instantiate()
	piece.isWhite = isWhite
	add_child(piece)
	piece.position = grid_to_pixel(x, y)
	return piece
	
# save piece on board 2D array		
func add_to_board(piece):
	var piece_x = piece.position.x
	var piece_y = piece.position.y
	var piece_vector = pixel_to_grid(piece_x, piece_y)
	board[piece_vector.x][piece_vector.y] = piece



