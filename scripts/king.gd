extends "res://scripts/piece.gd"

var white_path = "res://assets/White_King.png"
var black_path = "res://assets/Black_King.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_texture(white_path, black_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_possible_moves(position: Vector2):
	var possible_moves = []
	var moves_to_add = [Vector2(1, 1), Vector2(0, 1), Vector2(-1, 1), Vector2(-1, 0),
	Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1), Vector2(1, 0)]
	for i in moves_to_add:
		var move = position + i
		if (is_in_grid(move)):
			possible_moves.append(move)
	
	return possible_moves
