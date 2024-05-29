extends "res://scripts/piece.gd"

var white_path = "res://assets/White_Pawn.png"
var black_path = "res://assets/Black_Pawn.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_texture(white_path, black_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_possible_moves(position: Vector2, board, turn_player_isWhite):
	var possible_moves = []
	var moves_to_add = []
	
	if turn_player_isWhite:
		if is_in_grid(Vector2(position.x, position.y - 1)) && (board[position.x][position.y - 1] == null  || board[position.x][position.y - 1].pass_through):
			moves_to_add = [Vector2(0, -1)]
			# add first double step move
			if position.y == 6 && is_in_grid(Vector2(position.x, position.y - 2)) && (board[position.x][position.y - 2] == null || board[position.x][position.y - 2].pass_through):
				moves_to_add.append(Vector2(0, -2))
		# be able to take diagonal
		if is_in_grid(Vector2(position.x - 1, position.y - 1)) && board[position.x - 1][position.y - 1] != null &&  (board[position.x - 1 ][position.y - 1].pass_through ||  !board[position.x - 1 ][position.y - 1].is_chess_piece || board[position.x - 1][position.y - 1].isWhite != turn_player_isWhite):
			moves_to_add.append(Vector2(-1, -1))
		if is_in_grid(Vector2(position.x + 1, position.y - 1)) && board[position.x + 1][position.y - 1] != null &&  (board[position.x + 1][position.y - 1].pass_through || !board[position.x + 1][position.y - 1].is_chess_piece || board[position.x + 1][position.y - 1].isWhite != turn_player_isWhite):
			moves_to_add.append(Vector2(1, -1))
	
	elif turn_player_isWhite == false:
		if is_in_grid(Vector2(position.x, position.y + 1)) && (board[position.x][position.y + 1] == null || board[position.x][position.y + 1].pass_through):
			moves_to_add = [Vector2(0, 1)]
			# add first double step move
			if position.y == 1 && is_in_grid(Vector2(position.x, position.y + 2)) && (board[position.x][position.y + 2] == null || board[position.x][position.y + 2].pass_through):
				moves_to_add.append(Vector2(0, 2))
		# be able to take diagonal
		if is_in_grid(Vector2(position.x - 1, position.y + 1)) && board[position.x - 1][position.y + 1] != null && (board[position.x - 1][position.y + 1].pass_through || !board[position.x - 1][position.y + 1].is_chess_piece || board[position.x - 1][position.y + 1].isWhite != turn_player_isWhite):
			moves_to_add.append(Vector2(-1, 1))
		if is_in_grid(Vector2(position.x + 1, position.y + 1)) && board[position.x + 1][position.y + 1] != null && (board[position.x + 1][position.y + 1].pass_through || !board[position.x + 1][position.y + 1].is_chess_piece || board[position.x + 1][position.y + 1].isWhite != turn_player_isWhite):
			moves_to_add.append(Vector2(1, 1))
	
	# remove out of board moves or moves that will end in a piece of the same color
	for i in moves_to_add:
		var move = position + i
		if is_in_grid(move) && (possible_square(move.x, move.y, board) || board[move.x][move.y].isWhite != turn_player_isWhite):
			possible_moves.append(move)
	
	return possible_moves

func check_for_promotion(color, y):
	if color && y == 0:
		return true
	if color == false && y == 7:
		return true
