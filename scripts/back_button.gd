extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	$"/root/settings_global".visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	$"/root/settings_global".visible = false
	get_tree().change_scene_to_file("res://main_menu.tscn")
