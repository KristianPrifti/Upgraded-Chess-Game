extends "res://scripts/ability_in_shop.gd"

var being_set_up: bool
var buy_final_step: bool
var pieces: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(buy_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if being_set_up && !buy_final_step:
		step_2_of_buy_anility()
	elif being_set_up && buy_final_step:
		finish_buy_ability()

func buy_ability():
	if can_buy_ability():
		pieces = []
		being_set_up = true


func step_2_of_buy_anility():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		if GRID.is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] != null && \
		board[grid_position.x][grid_position.y].is_chess_piece && board[grid_position.x][grid_position.y].piece_type == "king" && \
		board[grid_position.x][grid_position.y].isWhite == turn_player.isWhite:
			var pieces_to_use = can_be_used([board[grid_position.x][grid_position.y]])
			if pieces_to_use.size() == 1:
				pieces.append(board[grid_position.x][grid_position.y])
				buy_final_step = true
				return
				
		being_set_up = false
		end_of_buy_ability()


func finish_buy_ability():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		if GRID.is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] != null && \
		board[grid_position.x][grid_position.y].is_chess_piece && board[grid_position.x][grid_position.y].piece_type == "rook" && \
		board[grid_position.x][grid_position.y].isWhite == turn_player.isWhite:
			pieces.append(board[grid_position.x][grid_position.y])
			var pieces_to_use = can_be_used(pieces)
			if pieces_to_use.size() == 2:
				var player_color = pieces_to_use[0].isWhite
				create_activate_ability_window(ability_name, player_color, activate, pieces_to_use)
				
		being_set_up = false
		buy_final_step = false
		end_of_buy_ability()

func activate(the_arr):
	var arr = the_arr[1]
	if can_activate(the_arr[0]):
		if arr.size() != 2:
			end_of_activation()
			return
		
		var k = arr[0]
		var r = arr[1]
		var k_pos = GRID.pixel_to_grid(k.position.x, k.position.y)
		var r_pos = GRID.pixel_to_grid(r.position.x, r.position.y)
		
		if k_pos.y == r_pos.y:
			var diff = k_pos.x - r_pos.x
			var direction
			if diff < 0:
				direction = 1
			else:
				direction = -1
			
			var spaces_between = row_spaces_between(k_pos.x, r_pos.x, k_pos.y)
			
			if spaces_between == 0:
				flip_k_and_r(k, r, k_pos, r_pos)
			elif spaces_between > 0:
				move_k_and_r(k, r, k_pos, r_pos, (2 * direction),  0, direction, 0)
				
		elif k_pos.x == r_pos.x:
			var diff = k_pos.y - r_pos.y
			var direction
			if diff < 0:
				direction = 1
			else:
				direction = -1
			
			var spaces_between = column_spaces_between(k_pos.y, r_pos.y, k_pos.x)
			
			if spaces_between == 0:
				flip_k_and_r(k, r, k_pos, r_pos)
			elif spaces_between > 0:
				move_k_and_r(k, r, k_pos, r_pos, 0,  (2 * direction), 0, direction)
		
	end_of_activation()

# get the spaces between the king and the rook
# return -1 if there are pieces that block the path
func row_spaces_between(k, r, y) -> int:
	var z = min(k, r)
	for i in (abs(k - r) - 1):
		if !(board[z + i + 1][y] == null || (board[z + i + 1][y].pass_through)):
			return -1
	return abs(k - r) - 1

func column_spaces_between(k, r, x) -> int:
	var z = min(k, r)
	for i in (abs(k - r) - 1):
		if !(board[x][z + i + 1] == null || (board[x][z + i + 1].pass_through)):
			return -1
	return abs(k - r) - 1

# used to flip position of rook and king when they are next to each other
func flip_k_and_r(k, r, k_vec, r_vec):
	var tween = create_tween()
	tween.tween_property(r, "position", GRID.grid_to_pixel(k_vec.x, k_vec.y), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	tween2.tween_property(k, "position", GRID.grid_to_pixel(r_vec.x, r_vec.y), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	board[k_vec.x][k_vec.y] = r
	board[r_vec.x][r_vec.y] = k

# used to move the king and rook when they are not next to each other
func move_k_and_r(k, r, k_vec, r_vec, k_x_move, k_y_move, r_x_move, r_y_move):
	# use tween to change possition of pices
	var tween = create_tween()
	tween.tween_property(k, "position", GRID.grid_to_pixel(k_vec.x + k_x_move, k_vec.y + k_y_move), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	tween2.tween_property(r, "position", GRID.grid_to_pixel(k_vec.x + r_x_move, k_vec.y + r_y_move), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	# make them null first so they don't interfeer later
	board[k_vec.x][k_vec.y] = null
	board[r_vec.x][r_vec.y] = null
	
	# collect gem if necessary
	if board[k_vec.x + k_x_move][k_vec.y  + k_y_move] != null && board[k_vec.x + k_x_move][k_vec.y + k_y_move].piece_type == "gem":
		board[k_vec.x + k_x_move][k_vec.y + k_y_move].queue_free()
		GRID.collect_gem(GRID.gem_value)
	# update the board array
	board[k_vec.x + k_x_move][k_vec.y + k_y_move] = k
	
	# collect gem if necessary
	if board[k_vec.x + r_x_move][k_vec.y + r_y_move] != null && board[k_vec.x + r_x_move][k_vec.y + r_y_move].piece_type == "gem":
		board[k_vec.x + r_x_move][k_vec.y + r_y_move].queue_free()
		GRID.collect_gem(GRID.gem_value)
	# update the board array
	board[k_vec.x + r_x_move][k_vec.y + r_y_move] = r
	
