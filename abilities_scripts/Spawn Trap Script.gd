extends "res://scripts/ability_in_shop.gd"

var being_set_up: bool
var trap_path = preload("res://trap.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$cost.pressed.connect(buy_ability)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if being_set_up:
		finish_buy_ability()

func buy_ability():
	if can_buy_ability():
		being_set_up = true

func finish_buy_ability():
	if Input.is_action_just_pressed("ui_click"):
		var click = GRID.get_local_mouse_position()
		var grid_position = GRID.pixel_to_grid(click.x, click.y)
		if GRID.is_in_grid(grid_position.x, grid_position.y) && board[grid_position.x][grid_position.y] == null:
			GRID.collect_gem(-cost)
			create_trap(grid_position.x, grid_position.y)
			
		being_set_up = false
		end_of_buy_ability()

func create_trap(x, y):
	var trap = trap_path.instantiate()
	GRID.add_child(trap)
	trap.position = GRID.grid_to_pixel(x, y)
	board[x][y] = trap
