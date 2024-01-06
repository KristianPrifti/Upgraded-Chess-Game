extends "res://scripts/piece.gd"

var white_path = "res://assets/White_Knight.png"
var black_path = "res://assets/Black_Knight.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_texture(white_path, black_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_possible_moves(position: Vector2, board, turn_player_isWhite):
	var possible_moves = []
	var moves_to_add = [Vector2(2, 1), Vector2(-2, 1), Vector2(1, 2), Vector2(1, -2),
	Vector2(2, -1), Vector2(-2, -1), Vector2(-1, 2), Vector2(-1, -2)]
	# remove out of board moves or moves that will end in a piece of the same color
	for i in moves_to_add:
		var move = position + i
		if is_in_grid(move) && (board[move.x][move.y] == null || board[move.x][move.y].isWhite != turn_player_isWhite):
			possible_moves.append(move)
	
	return possible_moves
