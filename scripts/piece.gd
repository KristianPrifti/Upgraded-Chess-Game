extends Node2D

@export var isWhite: bool
@export var piece_type: String
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
