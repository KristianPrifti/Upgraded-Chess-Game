extends Control

var affected_pieces
# singelton array
var ability_is_activating: Array

var queue
var tracker = self
@export var this_activation_started = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_visible(false)
	$affect.button_down.connect(glow)
	$affect.button_up.connect(end_glow)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if affected_pieces.size() != 0 && affected_pieces[0].get_activate_turn() == 0:
		ability_is_activating[0] = true
		self.set_visible(true)
	
	if queue.activation_tracker == tracker && queue.activation_finished[0]:
		queue.activation_finished[0] = false
		queue.activation_started[0] = false
		for piece in affected_pieces:
			piece.erase_counter()
		self.queue_free()
	
	if !this_activation_started:
		await $use.button_down
		if !(queue.activation_started[0]):
			queue.activation_started[0] = true
			this_activation_started = true
			queue.activation_tracker = tracker
			$use.emit_signal("pressed")


func create_ability(name, owner, ability, pieces):
	ability_is_activating = [false]
	queue = get_node("../")
	$name.text = name
	if owner:
		$owner.text = "White Player"
	else: 
		$owner.text = "Black Player"
	affected_pieces = pieces
	$use.pressed.connect(ability.bind([tracker, affected_pieces]))
	for x in affected_pieces:
		x.get_node("Sprite2D/counter_img/what_ability_is_active").set_tooltip_text(name)
	

func update_queue():
	var pieces_to_erase = []
	for piece in affected_pieces:
		piece.update_counter()
	if affected_pieces.size() == 0:
		self.queue_free()
#	elif affected_pieces[0].get_activate_turn() == 0:
#		ability_is_activating[0] = true
#		self.set_visible(true)
	

func erase_piece(piece):
	affected_pieces.erase(piece)

func glow():
	for x in affected_pieces:
		x.set_modulate(Color(1, 0.6, 1, 1))
	

func end_glow():
	for x in affected_pieces:
		x.set_modulate(Color(1, 1, 1, 1))
