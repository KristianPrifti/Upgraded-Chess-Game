extends "res://scripts/ability_in_shop.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(use_ability)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func use_ability():
	#GRID = get_node("../../../%grid")
	GRID.ability_in_use()
	board = GRID.get_board()
	turn_player = GRID.get_turn_player()
	
	
	if turn_player.isWhite:
		for i in GRID.get_num_rows():
			for j in GRID.get_num_colums():
				if board[i][j] != null && board[i][j].piece_type == "pawn":
					var piece = board[i][j]
					
					if turn_player.isWhite == piece.isWhite && board[i][j].is_in_grid(Vector2(i, j - 1)) && board[i][j - 1] == null:
						board[i][j].position = GRID.grid_to_pixel(i, j - 1)
						board[i][j] = null
						board[i][j - 1] = piece
						
	else:
		for i in GRID.get_num_rows():
			for j in GRID.get_num_colums():
				if board[7 - i][7 - j] != null && board[7 - i][7 - j].piece_type == "pawn":
					var piece = board[7- i][7- j]
		
					if !turn_player.isWhite && turn_player.isWhite == piece.isWhite && board[7 - i][7 - j].is_in_grid(Vector2(7 - i, 7- j + 1)) && board[7 - i][7 - j + 1] == null:
						board[7 - i][7 - j].position = GRID.grid_to_pixel(7- i, 7- j + 1)
						board[7 - i][7 - j] = null
						board[7 - i][7 - j + 1] = piece
