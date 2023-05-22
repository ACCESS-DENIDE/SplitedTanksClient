extends Control

var Manager:Node
var map={}
var root_cord=-(10*16*5)

func _ready():
	position=Vector2(-1910, -1030)

func _set_bloc(x:int, y:int, sender:Node):
	var x_pos=root_cord+(x*16*5)
	var y_pos=root_cord+(y*16*5)
	if($Grid/BlockSelector/Selector.is_anything_selected()):
		if(map.keys().has(str(x)+":"+str(y))):
			map.erase(str(x)+":"+str(y))
			_draw_map()
		if($Grid/BlockSelector/Selector.get_selected_items()[0]<8):
			map[str(x)+":"+str(y)]=$Grid/BlockSelector/Selector.get_selected_items()[0]+4
			Server._client_spawn(int(map[str(x)+":"+str(y)]), "Block"+str(x)+":"+str(y),Vector2(x_pos,y_pos))
	pass

func _load_map(path:String):
	if(path!=""):
		var program=FileAccess.open(path, FileAccess.READ)
		map=JSON.parse_string(program.get_as_text())
		_draw_map()
	pass

func _save_map(path:String):
	$Grid/SaveLoader/Path.deselect()
	if(path!=""):
		var Saver=FileAccess.open(path, FileAccess.WRITE)
		Saver.store_string(JSON.stringify(map))
		Saver.close()
	pass

func _draw_map():
	for i in Manager.get_children():
		i.queue_free()
	for i in map.keys():
		var x=root_cord+(int(i.split(":")[0])*16*5)
		var y=root_cord+(int(i.split(":")[1])*16*5)
		Server._client_spawn(int(map[i]), "Block"+str(x)+":"+str(y),Vector2(x,y))


func _on_load_pressed():
	_load_map($Grid/SaveLoader/Path.text)
	pass # Replace with function body.

func _on_save_pressed():
	_save_map($Grid/SaveLoader/Path.text)
	pass # Replace with function body.


func _on_back_pressed():
	NodeManager._main_menu()
	pass # Replace with function body.


func _on_undo_pressed():
	if(map.size()>0):
		map.erase(map.keys()[map.size()-1])
		_draw_map()
	pass # Replace with function body.
