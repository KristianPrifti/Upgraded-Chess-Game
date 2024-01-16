extends "res://scripts/piece.gd"

var white_path = "res://assets/White_Qween.png"
var black_path = "res://assets/Black_Qween.png"

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
	var e: int = 1
	var f: int = -1
	var g: int = 1
	var h: int = -1
	var k: int = -1
	var l: int = 1
		# rook like movement
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
	
		# bishop like movement
	# add moves to the right and up
	while is_in_grid(Vector2(position.x + e, position.y + e)) && (board[position.x + e][position.y + e] == null || board[position.x + e][position.y + e].pass_through):
		moves_to_add.append(Vector2(e, e))
		e += 1
	moves_to_add.append(Vector2(e, e))
	# add moves to the left and down
	while is_in_grid(Vector2(position.x + f, position.y + f)) && (board[position.x + f][position.y + f] == null || board[position.x + f][position.y + f].pass_through):
		moves_to_add.append(Vector2(f, f))
		f -= 1
	moves_to_add.append(Vector2(f, f))
	# add moves to the right and down
	while is_in_grid(Vector2(position.x + g, position.y + h)) && (board[position.x + g][position.y + h] == null || board[position.x + g][position.y + h].pass_through):
		moves_to_add.append(Vector2(g, h))
		g += 1
		h -= 1
	moves_to_add.append(Vector2(g, h))
	# add moves to the left and up
	while is_in_grid(Vector2(position.x + k, position.y + l)) && (board[position.x + k][position.y + l] == null || board[position.x + k][position.y + l].pass_through):
		moves_to_add.append(Vector2(k, l))
		k -= 1
		l += 1
	moves_to_add.append(Vector2(k, l))
	
	# remove out of board moves or moves that will end in a piece of the same color
	for i in moves_to_add:
		var move = position + i
		if is_in_grid(move) && (possible_square(move.x, move.y, board) || board[move.x][move.y].isWhite != turn_player_isWhite):
			possible_moves.append(move)
	
	return possible_moves
