extends Control
var sizer=Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	match get_window().mode:
		Window.MODE_FULLSCREEN:
			$"GridContainer/Window typeSelect".select(0)
			pass
		Window.MODE_MAXIMIZED:
			$"GridContainer/Window typeSelect".select(1)
			pass
		Window.MODE_EXCLUSIVE_FULLSCREEN:
			$"GridContainer/Window typeSelect".select(2)
			pass
		Window.MODE_WINDOWED:
			$"GridContainer/Window typeSelect".select(3)
			pass
	var mem=0
	if(GetInput.use_keys):
		mem+=1
	if(GetInput.use_mouse):
		mem+=2
	match mem:
		1:
			$GridContainer/SelectingControls.select(1)
			pass
		2:
			$GridContainer/SelectingControls.select(0)
			pass
		3:
			$GridContainer/SelectingControls.select(2)
			pass
	
	$GridContainer/HSlider.value=AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Effects"))+48
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(sizer.length()!=get_window().get_viewport().size.length()):
		$GridContainer/Resolution/XRes.text=str(get_window().get_viewport().size.x)
		$GridContainer/Resolution/YRes.text=str(get_window().get_viewport().size.y)
		sizer=get_window().get_viewport().size
	pass





func _set_resolution():
	var res_x=int($GridContainer/Resolution/XRes.text)
	var res_y=int($GridContainer/Resolution/YRes.text)
	var mem=get_window().get_viewport().size
	get_window().get_viewport().size.x=res_x
	get_window().get_viewport().size.y=res_y
	get_window().position.x-=res_x/2-mem.x/2
	get_window().position.y-=res_y/2-mem.y/2




func _on_set_pressed():
	_set_resolution()
	pass # Replace with function body.




func _on_back_pressed():
	NodeManager._save_settings()
	NodeManager._main_menu()
	pass # Replace with function body.


func _on_random_pressed():
	var rng = RandomNumberGenerator.new()
	randomize()
	$GridContainer/Resolution/XRes.text=str(rng.randi_range(1, 3840))
	$GridContainer/Resolution/YRes.text=str(rng.randi_range(1, 2160))
	_set_resolution()
	pass # Replace with function body.


func _on_selecting_controls_item_selected(index):
	match index:
		0:
			GetInput.use_keys=false
			GetInput.use_mouse=true
			pass
		1:
			GetInput.use_keys=true
			GetInput.use_mouse=false
			pass
		2:
			GetInput.use_keys=true
			GetInput.use_mouse=true
			pass
	pass # Replace with function body.


func _on_window_type_select_item_selected(index):
	match index:
		0:
			get_window().mode=Window.MODE_FULLSCREEN
			pass
		1:
			get_window().mode=Window.MODE_MAXIMIZED
			pass
		2:
			get_window().mode=Window.MODE_EXCLUSIVE_FULLSCREEN
			pass
		3:
			get_window().mode=Window.MODE_WINDOWED
			pass
	pass # Replace with function body.


func _on_h_slider_drag_ended(value_changed):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), $GridContainer/HSlider.value-48)
	$AudioStreamPlayer.play()
	pass # Replace with function body.
