extends "res://scripts/ability_in_shop.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(use_ability)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func use_ability():
	update_vars()
	GRID.ability_in_use()
	
	if has_enough_gems():
		
		var pieces = collect_pieces_to_use_ability_on()
		var pieces_to_use = can_be_used(pieces)
		if pieces_to_use.size() != 0:
			GRID.collect_gem(-cost)
			for x in pieces_to_use:
				x.set_ability(cooldown, "res://abilities_scripts/Peasants Unite Script.gd")
				x.set_counter()
			GRID.pieces_to_upgrade.append_array(pieces_to_use)

# this function returns an array with the pieces the ability *might* be used on
func collect_pieces_to_use_ability_on():
	var pieces = []
	for i in GRID.get_num_rows():
		for j in GRID.get_num_colums():
			if board[i][j] != null && board[i][j].piece_type == "pawn" &&  board[i][j].isWhite == turn_player.isWhite:
				pieces.append(board[i][j])
	return pieces

static func activate(i, j):
	var piece = board[i][j]
	if piece.isWhite && board[i][j].is_in_grid(Vector2(i, j - 1)) && board[i][j - 1] == null:
		board[i][j].position = GRID.grid_to_pixel(i, j - 1)
		board[i][j] = null
		board[i][j - 1] = piece
	elif !piece.isWhite && board[i][j].is_in_grid(Vector2(i, j + 1)) && board[i][j + 1] == null:
		board[i][j].position = GRID.grid_to_pixel(i, j + 1)
		board[i][j] = null
		board[i][j + 1] = piece


