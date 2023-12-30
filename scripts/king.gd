extends "res://scripts/piece.gd"

var white_path = "res://assets/White_King.png"
var black_path = "res://assets/Black_King.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_texture(white_path, black_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

