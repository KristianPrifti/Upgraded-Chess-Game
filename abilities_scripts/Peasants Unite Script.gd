extends "res://scripts/ability_in_shop.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(buy_ability)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func buy_ability():
#	update_vars()
#	if !(GRID.ability_is_doing_something[0]):
#		GRID.ability_in_use()
#
#		if has_enough_gems():
		if can_buy_ability():
		
			var pieces = collect_pieces_to_use_ability_on()
			var pieces_to_use = can_be_used(pieces)
			if pieces_to_use.size() != 0:
#				GRID.collect_gem(-cost)
				var player_color = pieces_to_use[0].isWhite
#				for x in pieces_to_use:
#					x.set_ability(cooldown)
#					x.set_counter()
				create_activate_ability_window(ability_name, player_color, activate, pieces_to_use)
			end_of_buy_ability()

# this function returns an array with the pieces the ability *might* be used on
func collect_pieces_to_use_ability_on():
	var pieces = []
	for i in GRID.get_num_rows():
		for j in GRID.get_num_colums():
			if board[i][j] != null && board[i][j].piece_type == "pawn" &&  board[i][j].isWhite == turn_player.isWhite:
				pieces.append(board[i][j])
	return pieces


func activate(the_arr):
#	var tracker = the_arr[0]
	var arr = the_arr[1]
#	if tracker == queue.activation_tracker:
	if can_activate(the_arr[0]):
		for z in arr:
			var z_vec = GRID.pixel_to_grid(z.position.x, z.position.y)
			var i = z_vec.x
			var j = z_vec.y
			var piece = board[i][j]
			if piece.isWhite && board[i][j].is_in_grid(Vector2(i, j - 1)) && board[i][j - 1] == null:
				var tween = create_tween()
				tween.tween_property(board[i][j], "position", GRID.grid_to_pixel(i, j - 1), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				board[i][j] = null
				board[i][j - 1] = piece
				GRID.start_promotion_if_necessary(i, j - 1)
			
			elif !piece.isWhite && board[i][j].is_in_grid(Vector2(i, j + 1)) && board[i][j + 1] == null:
				var tween = create_tween()
				tween.tween_property(board[i][j], "position", GRID.grid_to_pixel(i, j + 1), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				board[i][j] = null
				board[i][j + 1] = piece
				GRID.start_promotion_if_necessary(i, j + 1)
			
		end_of_activation()
#			GRID.ability_is_doing_something[0] = false
#			queue.activation_finished[0] = true
#				queue.activation_finished[0] = true
#				queue.activation_started[0] = false
#				queue.activation_finished[0] = false
