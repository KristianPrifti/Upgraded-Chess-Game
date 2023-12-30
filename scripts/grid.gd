extends Node2D

var num_colums: int = 8
var num_rows: int = 8
var x_start = 50
var y_start = 50
var offset = 100

var board = []

var pieces_list = [
	preload("res://pieces/rook.tscn"),
	preload("res://pieces/knight.tscn"), 
	preload("res://pieces/bishop.tscn"), 
	preload("res://pieces/qween.tscn"), 
	preload("res://pieces/king.tscn"), 
	preload("res://pieces/pawn.tscn"), 
]

# Called when the node enters the scene tree for the first time.
func _ready():
	board = make_2d_array()
	spawn_initial_pices()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func make_2d_array():
	var array = []
	for i in num_colums:
		array.append([])
		for j in num_rows:
			array.append(null)
	return array

# change the column and raw number to pixel values 
func grid_to_pixel(column, row):
	var pixel_x = x_start + offset * column
	var pixel_y = y_start + offset * row
	return Vector2(pixel_x, pixel_y)


func spawn_initial_pices():
	var rook = pieces_list[0]
	var knight = pieces_list[1]
	var bishop = pieces_list[2]
	var qween = pieces_list[3]
	var king = pieces_list[4]
	var pawn = pieces_list[5]
	
	# add pawns
	for i in num_colums:
		# create pices
		var white_piece = pawn.instantiate()
		var black_piece = pawn.instantiate()
		# set color
		white_piece.isWhite = true
		black_piece.isWhite = false
		# add them as childern to the grid
		add_child(white_piece)
		add_child(black_piece)
		# add white pawns to 7nd row
		white_piece.position = grid_to_pixel(i, 6)
		# add black pawns to 2th row
		black_piece.position = grid_to_pixel(i, 1)
	
	# add other pices that are not pawns
	for i in 2:
		# create pieces
		var white_rook = rook.instantiate()
		var black_rook = rook.instantiate()
		var white_knight = knight.instantiate()
		var black_knight = knight.instantiate()
		var white_bishop = bishop.instantiate()
		var black_bishop = bishop.instantiate()
		# set color
		white_rook.isWhite = true
		black_rook.isWhite = false
		white_knight.isWhite = true
		black_knight.isWhite = false
		white_bishop.isWhite = true
		black_bishop.isWhite = false
		# add them a childern to the grid
		add_child(white_rook)
		add_child(black_rook)
		add_child(white_knight)
		add_child(black_knight)
		add_child(white_bishop)
		add_child(black_bishop)
		# only make 1 king a qween of each side and add the first group of pices
		if i == 0:
			var white_qween = qween.instantiate()
			var black_qween = qween.instantiate()
			var white_king = king.instantiate()
			var black_king = king.instantiate()
			white_qween.isWhite = true
			black_qween.isWhite = false
			white_king.isWhite = true
			black_king.isWhite = false
			add_child(white_qween)
			add_child(black_qween)
			add_child(white_king)
			add_child(black_king)
			
			# put them in the right location
			white_rook.position = grid_to_pixel(0, 7)
			black_rook.position = grid_to_pixel(0, 0)
			white_knight.position = grid_to_pixel(1, 7)
			black_knight.position = grid_to_pixel(1, 0)
			white_bishop.position = grid_to_pixel(2, 7)
			black_bishop.position = grid_to_pixel(2, 0)
			white_qween.position = grid_to_pixel(3, 7)
			black_qween.position = grid_to_pixel(3, 0)
			white_king.position = grid_to_pixel(4, 7)
			black_king.position = grid_to_pixel(4, 0)
		else:
			white_rook.position = grid_to_pixel(7, 7)
			black_rook.position = grid_to_pixel(7, 0)
			white_knight.position = grid_to_pixel(6, 7)
			black_knight.position = grid_to_pixel(6, 0)
			white_bishop.position = grid_to_pixel(5, 7)
			black_bishop.position = grid_to_pixel(5, 0)
			
			
			


