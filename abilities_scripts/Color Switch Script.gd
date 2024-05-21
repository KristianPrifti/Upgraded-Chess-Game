extends "res://scripts/ability_in_shop.gd"

var being_set_up: bool
var activation_in_progress: bool
var bishop_affected

# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(use_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if being_set_up:
		collect_pieces_to_use_ability_on()
	if activation_in_progress:
		finish_activation()


func use_ability():
	if !(activation_in_progress):
		update_vars()
	
		GRID.ability_in_use()
	
		if has_enough_gems():
			being_set_up = true;
			GRID.ability_is_doing_something[0] = true

func collect_pieces_to_use_ability_on():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		if GRID.is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] != null && \
		board[grid_position.x][grid_position.y].piece_type == "bishop" && board[grid_position.x][grid_position.y].isWhite == turn_player.isWhite:
			var pieces_to_use = can_be_used([board[grid_position.x][grid_position.y]])
			if pieces_to_use.size() != 0:
				GRID.collect_gem(-cost)
				var player_color = pieces_to_use[0].isWhite
				for x in pieces_to_use:
					x.set_ability(cooldown, "res://abilities_scripts/Color Switch Script.gd")
					x.set_counter()
				create_activate_ability_window(ability_name, player_color, activate, pieces_to_use)
		being_set_up = false
		GRID.ability_is_doing_something[0] = false

func activate(the_arr):
	var tracker = the_arr[0]
	var arr = the_arr[1]
	if tracker == queue.activation_tracker:
		activation_in_progress = true
		GRID.ability_is_doing_something[0] = true
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
			
		# if there isn't any place to move the bishop do nothing
		for u in hold_ability_positions:
			for v in u:
				if v != null:
					return
			
		reset_at_end_of_activation()
		activation_in_progress = false
		GRID.ability_is_doing_something[0] = false
			
		queue.activation_finished[0] = true
		


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
			
			reset_at_end_of_activation()
			activation_in_progress = false
			GRID.ability_is_doing_something[0] = false
			
			queue.activation_finished[0] = true
