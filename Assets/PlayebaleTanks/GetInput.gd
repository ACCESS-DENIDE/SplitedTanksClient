extends Control

var use_mouse:bool=true
var use_keys:bool=true

var last=-1
var list={}
var flg:bool=false

func _input(event):
	if(use_keys):
		if(Input.is_action_just_pressed("my_shoot_keys")):
			Server._pew()
		if(Input.is_action_just_pressed("my_ability_keys")):
			Server._PU_use()
	
	if(Input.is_action_just_pressed("my_build")):
		Server._build_mode()
	
	if(use_mouse):
		var mouse=get_global_mouse_position()
		if(Input.is_action_just_pressed("my_shoot_mouse")):
			if(abs(mouse.x)<880 and abs(mouse.y)<880):
				Server._pew()
		if(Input.is_action_just_pressed("my_ability_mouse")):
			if(abs(mouse.x)<880 and abs(mouse.y)<880):
				Server._PU_use()
		

func _process(delta):
	if (Input.is_action_just_pressed("my_move_up")):
		list[list.size()]=0
	if (Input.is_action_just_pressed("my_move_down")):
		list[list.size()]=1
	if (Input.is_action_just_pressed("my_move_right")):
		list[list.size()]=2
	if (Input.is_action_just_pressed("my_move_left")):
		list[list.size()]=3
		
		
	if (Input.is_action_just_released("my_move_up")):
		for i in list.keys():
			if(list[i]==0):
				list.erase(i)
	if (Input.is_action_just_released("my_move_down")):
		for i in list.keys():
			if(list[i]==1):
				list.erase(i)
	if (Input.is_action_just_released("my_move_right")):
		for i in list.keys():
			if(list[i]==2):
				list.erase(i)
	if (Input.is_action_just_released("my_move_left")):
		for i in list.keys():
			if(list[i]==3):
				list.erase(i)
	
	if (list.size()>0):
		last=list[list.keys()[list.keys().size()-1]]
		flg=true
		Server._ini_move(last)
	else:
		if(flg):
			flg=false
			Server._ini_move(-1)


