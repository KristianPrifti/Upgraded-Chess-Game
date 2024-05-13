extends "res://scripts/ability_in_shop.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(use_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turn_player = get_node("../../../%grid").get_turn_player()


func use_ability():
	print("4")

