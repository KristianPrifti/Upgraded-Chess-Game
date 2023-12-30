extends Node2D

@export var isWhite: bool
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
