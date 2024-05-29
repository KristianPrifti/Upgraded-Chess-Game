extends Node2D
@export var piece_type: String
# var is_chess_piece checks if the piece is a regular chess piece (can move, capture and those kind of things)
@export var is_chess_piece: bool = false
# var pass_through is to check if a piece can pass through this object or it cannot move further
@export var pass_through: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
