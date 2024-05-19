extends Control

var affected_pieces
# singelton array
var ability_is_activating: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_visible(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_ability(name, owner, ability, pieces):
	ability_is_activating = [false]
	$name.text = name
	if owner:
		$owner.text = "White Player"
	else: 
		$owner.text = "Black Player"
	affected_pieces = pieces
	$use.pressed.connect(ability.bind(affected_pieces))
	

func update_queue():
	var pieces_to_erase = []
	for piece in affected_pieces:
		piece.update_counter()
	if affected_pieces[0].get_activate_turn() == 0:
		ability_is_activating[0] = true
		self.set_visible(true)
		await $use.pressed
		self.queue_free()
		for piece in affected_pieces:
			piece.erase_counter()
	

func erase_piece(piece):
	affected_pieces.erase(piece)
