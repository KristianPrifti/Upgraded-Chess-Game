extends Node2D

@export var isWhite: bool
@export var piece_type: String
# var is_chess_piece checks if the piece is a regular chess piece (can move, capture and those kind of things)
@export var is_chess_piece: bool
# var pass_through is to check if a piece can pass through this object or it cannot move further
@export var pass_through: bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initial_texture(white_path, black_path):
	if self.isWhite == true:
		$Sprite2D.texture = ResourceLoader.load(white_path)
	elif self.isWhite == false:
		$Sprite2D.texture = ResourceLoader.load(black_path)

func is_in_grid(position: Vector2):
	if position.x >= 0 && position.x < 8 && position.y >=0 && position.y < 8:
		return true
	return false
	
# check if the square is null or a gem
func possible_square(x, y, board):
	if board[x][y] == null || board[x][y].piece_type == "gem":
		return true
