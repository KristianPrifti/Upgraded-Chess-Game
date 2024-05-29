extends "res://scripts/ability_in_shop.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(buy_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func buy_ability():
	# you can buy it even if you don't have enough and go in the negative
	GRID.collect_gem(-cost)
	end_of_buy_ability()
