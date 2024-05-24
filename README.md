Changelog:
- cool
- chess
- game
- ( ͡° ͜ʖ ͡°)

How to create an ability documentation:
- Place the ability's icon in the fallder named "abilities_assets".
- In "settings_global.gd" script, in the "create_all_abilities()" method call
	"create_settings_ability(icon_path, cooldown, cost, name, description)"
	where all the arguments have type String.
- Make sure that the ability script has its name in this format:
	If the ability is "Peasants Unite" the script file should be "Peasants Unite Script.gd" 
		with that capitalization and spacing.
	It should be put on the "abilities_scripts" folder. 
- The script should extend "res://scripts/ability_in_shop.gd".
- In the "_ready()" function call "$cost.pressed.connect(buy_ability)".
- Every ability script should have "buy_ability()" and "activate(the_arr)" methods.
	"buy_ability()" is activated when the player buys an ability in the shop
	"activate(the_arr)" is activated when the user activates the ability from the Abilities 
		to Activate queue
- "buy_ability()" explanation:
	At the beggining of this function you should call "if can_buy_ability():" This function 
		returns true if the player can buy the specific ability at that moment.
	In an array, collect pices that the ability might be used on and pass that array to 
		"can_be_used(arr)". This function will fillter out the pieces that the ability 
		cannot be used on. (mainly if the piece already has one ability that will be activated)
	After checking that the returned array still has the necessary pieces for the ability to 
		activate you should call 
		"create_activate_ability_window(ability_name, player_color, activate, pieces_to_use)"
		where player_color is a bool that represents the player that should activate the ability
			(true for white and false for black)
		activate is the "activate(the_arr)" function 
		and pieces_to_use is the array that "can_buy_ability()" returned.
		This function creates an activate_ability_window for the specific ability that affects the
			specific pieces and adds it to the queue.
	Then at the end call "end_of_buy_ability()".
	Note: This does not have to be all in one function, split it up in multiple functions if 
		you like, as long at it all starts at "buy_ability()" and all the key points are completed.
- "activate(the_arr)" explanation:
	Argument the_arr is an array whose first element is a tracker/the specific ability window 
		activated. The tracker is used to track if the correct ability window is trying to activate.
		The second element is an array that contains all the pieces affected by the ability.
	Somewhere in the beggining of the "activate(the_arr)" you should call 
		"if can_activate(tracker):" (tracker is the_arr[0]) This returns true if this specific
		ability can be activated that time.
	Then there is the code of what the ability should do to the pieces being affected (the_arr[1]).
	Then at the end call end_of_activation().
	Note: Again this doesn't all have to be one function
- Look at an allready implemented ability similar to yours for more insperation!!!
