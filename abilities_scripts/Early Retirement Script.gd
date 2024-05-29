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
		board[grid_position.x][grid_position.y].is_chess_piece && board[grid_position.x][grid_position.y].piece_type != "king" && \
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
		
		remove_current_crown_if_it_exists(arr[0])
		var sprite = Sprite2D.new()
		sprite.name = "Early_Retirement_Crown"
		sprite.texture = ResourceLoader.load(get_correct_texture(arr[1]))
		arr[1].get_node("Sprite2D").add_child(sprite)
		arr[1].get_node("Sprite2D").move_child(sprite, 0)
		arr[0].piece_type = ""
		arr[1].piece_type = "king"
	end_of_activation()

func remove_current_crown_if_it_exists(p):
	var children = p.get_node("Sprite2D").get_children()
	for i in children:
		if i.name == "Early_Retirement_Crown":
			i.queue_free()

func get_correct_texture(p) -> String:
	if p.isWhite:
		if p.piece_type == "qween":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Qween_White.png"
		elif p.piece_type == "rook":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Rook_White.png"
		elif p.piece_type == "pawn":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Pawn_White.png"
		elif p.piece_type == "knight":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Knight_White.png"
		elif p.piece_type == "bishop":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Bishop_White.png"
			
	else:
		if p.piece_type == "qween":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Qween_Black.png"
		elif p.piece_type == "rook":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Rook_Black.png"
		elif p.piece_type == "pawn":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Pawn_Black.png"
		elif p.piece_type == "knight":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Knight_Black.png"
		elif p.piece_type == "bishop":
			return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Bishop_Black.png"
	
	return "res://abilities_assets/Early_Retirement_Assets/Early_Retirement_Empty.png"
