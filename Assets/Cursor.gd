extends Control

var root_cord=-(10*16*5)
var x_val:int=0
var y_val:int=0
var block_type=0
var Interf

func _ready():
	x_val=10
	y_val=10

func _input(event):
	var x=0
	var y=0
	if(GetInput.use_keys):
		y=Input.get_axis("my_move_up", "my_move_down")
		x=Input.get_axis("my_move_left", "my_move_right")
		if(Input.is_action_just_pressed("my_shoot_keys")):
			Interf._set_bloc(x_val, y_val, self)
	if(GetInput.use_mouse):
		var mouse=get_global_mouse_position()
		mouse=mouse-Vector2(40, 40)
		if(abs(mouse.x)<880 and abs(mouse.y)<880):
			x_val=floor((mouse.x-root_cord)/80)+1
			y_val=floor((mouse.y-root_cord)/80)+1
			if(Input.is_action_just_pressed("my_shoot_mouse")):
				Interf._set_bloc(x_val, y_val, self)
	x_val+=x
	y_val+=y
	if(x_val<0):
		x_val=0
	if(x_val>21):
		x_val=21
	if(y_val<0):
		y_val=0
	if(y_val>21):
		y_val=21
	position.x=root_cord+(x_val*16*5)
	position.y=root_cord+(y_val*16*5)


