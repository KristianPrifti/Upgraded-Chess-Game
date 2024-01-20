extends VBoxContainer

var window_path = preload("res://settings_upgrade.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_all_abilities()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_settings_ability(icon_path, ability_name, ability_description):
	var window = window_path.instantiate()
	add_child(window)
	window.create_setting_upgrade(icon_path, ability_name, ability_description)

func create_all_abilities():
	var good_name_icon_path = "res://pawn_group_temp_settings.png"
	var good_name_ability_name = "good_name_"
	var good_name_ability_description = "ability_description_high_quality"
	create_settings_ability(good_name_icon_path, good_name_ability_name, good_name_ability_description)
