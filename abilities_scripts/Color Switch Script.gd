extends "res://scripts/ability_in_shop.gd"

var being_set_up: bool
var activation_in_progress: bool
var bishop_affected

# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(buy_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if being_set_up:
		finish_buy_ability()
	if activation_in_progress:
		finish_activation()


func buy_ability():
	if can_buy_ability():
		being_set_up = true

func finish_buy_ability():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		if GRID.is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] != null && \
		board[grid_position.x][grid_position.y].piece_type == "bishop" && board[grid_position.x][grid_position.y].isWhite == turn_player.isWhite:
			var pieces_to_use = can_be_used([board[grid_position.x][grid_position.y]])
			if pieces_to_use.size() != 0:
				var player_color = pieces_to_use[0].isWhite
				create_activate_ability_window(ability_name, player_color, activate, pieces_to_use)

		being_set_up = false
		end_of_buy_ability()

func activate(the_arr):
	var arr = the_arr[1]
	if can_activate(the_arr[0]):
		activation_in_progress = true
		bishop_affected = arr[0]
		var z_vec = GRID.pixel_to_grid(bishop_affected.position.x, bishop_affected.position.y)
		var i = z_vec.x
		var j = z_vec.y
		var piece = board[i][j]
		if GRID.is_in_grid(i, j - 1) && board[i][j - 1] == null:
			add_active_symbol_ability(i, j - 1)
		if GRID.is_in_grid(i, j + 1) && board[i][j + 1] == null:
			add_active_symbol_ability(i, j + 1)
		if GRID.is_in_grid(i - 1, j) && board[i - 1][j] == null:
			add_active_symbol_ability(i - 1, j)
		if GRID.is_in_grid(i + 1, j) && board[i + 1][j] == null:
			add_active_symbol_ability(i + 1, j)
			
		# check if there is a place to move the bishop
		for u in hold_ability_positions:
			for v in u:
				if v != null:
					return
			
		# resent the values if the isn't any place to move the bishop
		activation_in_progress = false
		end_of_activation()
		


func finish_activation():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		var i = grid_position.x
		var j = grid_position.y
		if GRID.is_in_grid(i, j) && hold_ability_positions[i][j] != null:
			var tween = create_tween()
			tween.tween_property(bishop_affected, "position", GRID.grid_to_pixel(i, j), .3).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			var z_vec = GRID.pixel_to_grid(bishop_affected.position.x, bishop_affected.position.y)
			board[z_vec.x][z_vec.y] = null
			board[i][j] = bishop_affected
			
			activation_in_progress = false
			end_of_activation()
