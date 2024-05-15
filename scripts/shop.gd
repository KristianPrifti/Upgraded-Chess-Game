extends ScrollContainer

var upgrade_window_path = preload("res://upgrade_window.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	create_all_abilities()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_settings_ability(icon_texture, cooldown: int, cost: int, ability_name: String, ability_description):
	var window = upgrade_window_path.instantiate()
	get_child(0).add_child(window)
	window.create_ability(icon_texture, cooldown, cost, ability_name, ability_description)
	
func create_all_abilities():
	var abilities_list = settings_global.get_abilities()
	var number_of_abilities = abilities_list.size()
	var curr_ability = 0
	if abilities_list[0].get_node("name").text == "All Abilities":
		pass
		
	while curr_ability < number_of_abilities:
		
		create_settings_ability(abilities_list[curr_ability].get_node("icon").texture, get_int_from_text(abilities_list[curr_ability].get_node("cooldown").text), get_int_from_text(abilities_list[curr_ability].get_node("cost").text), abilities_list[curr_ability].get_node("name").text, abilities_list[curr_ability].get_node("description").text)
		curr_ability += 1

# used to get int for the cooldown and the cost from the string
func get_int_from_text(text) -> int:
	var arr = text
	var ans_arr = []
	var ans: int
	for i in arr.length():
		if arr[i]=="0" || arr[i]=="1" || arr[i]=="2" || arr[i]=="3" || arr[i]=="4" || arr[i]=="5" || arr[i]=="6" || arr[i]=="7" || arr[i]=="8" || arr[i]=="9":
			ans_arr.append(int(arr[i]))
	
	for j in ans_arr.size():
		var x = ans_arr.size()
		ans += (ans_arr[j] * pow(10, x-1-j))
	return ans
	
