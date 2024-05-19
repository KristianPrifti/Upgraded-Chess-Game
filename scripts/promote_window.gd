extends Control

var GRID

# path for the icons
var knight_white_path = "res://assets/White_Knight.png"
var bishop_white_path = "res://assets/White_Bishop.png"
var rook_white_path = "res://assets/White_Rook.png"
var qween_white_path = "res://assets/White_Qween.png"
var knight_black_path = "res://assets/Black_Knight.png"
var bishop_black_path =  "res://assets/Black_Bishop.png"
var rook_black_path = "res://assets/Black_Rook.png"
var qween_black_path = "res://assets/Black_Qween.png"

var knight_white
var bishop_white
var rook_white
var qween_white
var knight_black
var bishop_black
var rook_black
var qween_black

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_visible(false)
	GRID = get_node("../%grid")
	load_images()
	set_up_buttons()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_up_buttons():
	$Button1.pressed.connect(promote_to_knight)
	$Button2.pressed.connect(promote_to_bishop)
	$Button3.pressed.connect(promote_to_rook)
	$Button4.pressed.connect(promote_to_qween)

func promote_to_knight():
	var piece
	piece = GRID.spawn_initial(GRID.pieces_list[1], GRID.promote_pawn_color, GRID.promote_pawn_location.x, GRID.promote_pawn_location.y)
	GRID.complete_promotion(piece)
	self.set_visible(false)

func promote_to_bishop():
	var piece
	piece = GRID.spawn_initial(GRID.pieces_list[2], GRID.promote_pawn_color, GRID.promote_pawn_location.x, GRID.promote_pawn_location.y)
	GRID.complete_promotion(piece)
	self.set_visible(false)

func promote_to_rook():
	var piece
	piece = GRID.spawn_initial(GRID.pieces_list[0], GRID.promote_pawn_color, GRID.promote_pawn_location.x, GRID.promote_pawn_location.y)
	GRID.complete_promotion(piece)
	self.set_visible(false)

func promote_to_qween():
	var piece
	piece = GRID.spawn_initial(GRID.pieces_list[3], GRID.promote_pawn_color, GRID.promote_pawn_location.x, GRID.promote_pawn_location.y)
	GRID.complete_promotion(piece)
	self.set_visible(false)

func set_color(isWhite):
	if isWhite: 
		$Button1.icon = knight_white
		$Button2.icon = bishop_white
		$Button3.icon = rook_white
		$Button4.icon = qween_white
	else:
		$Button1.icon = knight_black
		$Button2.icon = bishop_black
		$Button3.icon = rook_black
		$Button4.icon = qween_black
	self.set_visible(true)

func load_images():
	knight_white = ResourceLoader.load(knight_white_path)
	bishop_white = ResourceLoader.load(bishop_white_path)
	rook_white = ResourceLoader.load(rook_white_path)
	qween_white = ResourceLoader.load(qween_white_path)
	knight_black = ResourceLoader.load(knight_black_path)
	bishop_black = ResourceLoader.load(bishop_black_path)
	rook_black = ResourceLoader.load(rook_black_path)
	qween_black = ResourceLoader.load(qween_black_path)
