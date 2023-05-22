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

var amounts={}
var Special:int

func _ready():
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
	
