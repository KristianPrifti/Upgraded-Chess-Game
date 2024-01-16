extends "res://scripts/piece.gd"

var white_path = "res://assets/White_Rook.png"
var black_path = "res://assets/Black_Rook.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_texture(white_path, black_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_possible_moves(position: Vector2, board, turn_player_isWhite):
	var possible_moves = []
	var moves_to_add = []
	var a: int = 1
	var b: int = -1
	var c: int = 1
	var d: int = -1
	# add moves to the right
	while is_in_grid(Vector2(position.x + a, position.y)) && (board[position.x + a][position.y] == null || board[position.x + a][position.y].pass_through):
		moves_to_add.append(Vector2(a, 0))
		a += 1
	moves_to_add.append(Vector2(a, 0))
	# add moves to the left
	while is_in_grid(Vector2(position.x + b, position.y)) && (board[position.x + b][position.y] == null || board[position.x + b][position.y].pass_through):
		moves_to_add.append(Vector2(b, 0))
		b -= 1
	moves_to_add.append(Vector2(b, 0))
	# add moves up
	while is_in_grid(Vector2(position.x, position.y + c)) && (board[position.x][position.y + c] == null || board[position.x][position.y + c].pass_through):
		moves_to_add.append(Vector2(0, c))
		c += 1
	moves_to_add.append(Vector2(0, c))
	# add moves down
	while is_in_grid(Vector2(position.x, position.y + d)) && (board[position.x][position.y + d] == null || board[position.x][position.y + d].pass_through):
		moves_to_add.append(Vector2(0, d))
		d -= 1
	moves_to_add.append(Vector2(0, d))
	
	# remove out of board moves or moves that will end in a piece of the same color
	for i in moves_to_add:
		var move = position + i
		if is_in_grid(move) && (possible_square(move.x, move.y, board) || board[move.x][move.y].isWhite != turn_player_isWhite):
			possible_moves.append(move)
	
	return possible_moves
