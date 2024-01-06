extends "res://scripts/piece.gd"

var white_path = "res://assets/White_Bishop.png"
var black_path = "res://assets/Black_Bishop.png"

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
	var e: int = -1
	var f: int = 1
	# add moves to the right and up
	while is_in_grid(Vector2(position.x + a, position.y + a)) && board[position.x + a][position.y + a] == null:
		moves_to_add.append(Vector2(a, a))
		a += 1
	moves_to_add.append(Vector2(a, a))
	# add moves to the left and down
	while is_in_grid(Vector2(position.x + b, position.y + b)) && board[position.x + b][position.y + b] == null:
		moves_to_add.append(Vector2(b, b))
		b -= 1
	moves_to_add.append(Vector2(b, b))
	# add moves to the right and down
	while is_in_grid(Vector2(position.x + c, position.y + d)) && board[position.x + c][position.y + d] == null:
		moves_to_add.append(Vector2(c, d))
		c += 1
		d -= 1
	moves_to_add.append(Vector2(c, d))
	# add moves to the left and up
	while is_in_grid(Vector2(position.x + e, position.y + f)) && board[position.x + e][position.y + f] == null:
		moves_to_add.append(Vector2(e, f))
		e -= 1
		f += 1
	moves_to_add.append(Vector2(e, f))
	
	# remove out of board moves or moves that will end in a piece of the same color
	for i in moves_to_add:
		var move = position + i
		if is_in_grid(move) && (board[move.x][move.y] == null || board[move.x][move.y].isWhite != turn_player_isWhite):
			possible_moves.append(move)
	
	return possible_moves
