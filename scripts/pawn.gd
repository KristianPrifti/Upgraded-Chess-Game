extends "res://scripts/piece.gd"

var white_path = "res://assets/White_Pawn.png"
var black_path = "res://assets/Black_Pawn.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_texture(white_path, black_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

