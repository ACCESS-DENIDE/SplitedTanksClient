extends Node


@onready var UInode=$UIlayer
@onready var GameplayNode=$GameplayLayer

var redir
var Game=preload("res://UI/InGameUI.tscn")
var Connector=preload("res://UI/ConnectionGrid.tscn")
var Main=preload("res://UI/main_menu.tscn")
var Cam=preload("res://UI/InGameCamera.tscn")
var Curs=preload("res://Assets/Cursor.tscn")
var EditorUI=preload("res://UI/MapEditorUI.tscn")
var Settings=preload("res://UI/Settings.tscn")

var amounts={}
var Special:int

func _ready():
	_load_settings()
	_main_menu()

func _main_menu():
	for i in UInode.get_children():
		i.queue_free()
	for i in GameplayNode.get_children():
		i.queue_free()
	UInode.add_child(Main.instantiate())
	multiplayer.multiplayer_peer=null
	redir=null
	pass

func _connection_grid():
	for i in UInode.get_children():
		i.queue_free()
	for i in GameplayNode.get_children():
		i.queue_free()
	UInode.add_child(Connector.instantiate())
	pass

func _settings():
	for i in UInode.get_children():
		i.queue_free()
	for i in GameplayNode.get_children():
		i.queue_free()
	UInode.add_child(Settings.instantiate())
	pass

func _game():
	for i in UInode.get_children():
		i.queue_free()
	UInode.add_child(Cam.instantiate())
	var g=Game.instantiate()
	redir=g
	UInode.add_child(g)

func _mapEdior():
	for i in UInode.get_children():
		i.queue_free()
	for i in GameplayNode.get_children():
		i.queue_free()
	UInode.add_child(Cam.instantiate())
	var UI=EditorUI.instantiate()
	UI.Manager=GameplayNode
	UInode.add_child(UI)
	var c=Curs.instantiate()
	c.Interf=UI
	UInode.add_child(c)

func _targeting():
	var c=Curs.instantiate()
	c.Interf=Server
	UInode.add_child(c)

func _set_locals(data={}):
	if(redir!=null):
		redir._load_data(data)
	


func _save_settings():
	var set={}
	set["res"]=get_window().size
	set["displayMode"]=get_window().mode
	set["useMouse"]=GetInput.use_mouse
	set["useKeys"]=GetInput.use_keys
	var Saver=FileAccess.open("Settings.json", FileAccess.WRITE)
	Saver.store_string(JSON.stringify(set))
	Saver.close()


func _load_settings():
	if(FileAccess.file_exists("Settings.json")):
		var set={}
		var loader=FileAccess.open("Settings.json", FileAccess.READ)
		set=JSON.parse_string(loader.get_as_text())
		loader.close()
		var res_str=set["res"].left(-1)
		res_str=res_str.right(-1)
		get_window().size=Vector2(int(res_str.split(",")[0]),int(res_str.split(",")[1]) )
		get_window().mode=set["displayMode"]
		GetInput.use_mouse=set["useMouse"]
		GetInput.use_keys=set["useKeys"]
