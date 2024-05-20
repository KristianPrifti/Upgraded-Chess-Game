extends Control

var affected_pieces
# singelton array
var ability_is_activating: Array

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_visible(false)
	$affect.button_down.connect(glow)
	$affect.button_up.connect(end_glow)


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
	for x in affected_pieces:
		x.get_node("Sprite2D/counter_img/what_ability_is_active").set_tooltip_text(name)
	

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

func glow():
	for x in affected_pieces:
		x.set_modulate(Color(1, 0.6, 1, 1))
	

func end_glow():
	for x in affected_pieces:
		x.set_modulate(Color(1, 1, 1, 1))
