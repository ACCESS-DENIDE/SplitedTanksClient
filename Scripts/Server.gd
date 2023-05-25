extends Node

var name_pl:String

var response_Label=null

var connected:bool

var meta_request:bool
var stored_meta:int=-1
func _ready():
	multiplayer.connected_to_server.connect(_connected)
	multiplayer.server_disconnected.connect(_disconected)
	multiplayer.connection_failed.connect(_failed)

func _connecting(ip:String, port:String, name_inst:String):
	name_pl=name_inst
	if ip == "":
		OS.alert("Need a remote to connect to.")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(ip, int(port))
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
	multiplayer.multiplayer_peer = peer

func _connected():
	connected=true
	if(response_Label!=null):
		response_Label.text="connected"
	#rpc_id(1, "_setName", name_pl)
	NodeManager._game()
	pass

func _failed():
	connected=true
	multiplayer.multiplayer_peer=null
	if(response_Label!=null):
		response_Label.text="failed"
	NodeManager._connection_grid()
	pass

func _disconected():
	connected=false
	multiplayer.multiplayer_peer=null
	if(response_Label!=null):
		response_Label.text="disconnected"
	NodeManager._connection_grid()
	pass

func _set_response_label(ref:Node):
	response_Label=ref

func _ini_move(dir:int):
	if connected:
		rpc_id(1, "_call_move", dir)

@rpc("any_peer")
func _unload_map_cli():
	for i in NodeManager.GameplayNode.get_children():
		if(i.name.contains("Block")):
			NodeManager.GameplayNode.remove_child(i)
	pass

@rpc("unreliable","any_peer")
func _sync(name:String, pos:Vector2, rot:float):
	for i in NodeManager.GameplayNode.get_children():
		if(i.name==name):
			i.position=pos
			i.rotation=rot

@rpc("any_peer")
func _update_locals(data={}):
	NodeManager._set_locals(data)
	pass


@rpc("any_peer")
func _client_spawn(id:int, name:String, pos:Vector2, rot:float=0.0):
	var instance
	var size=5
	match id:
		0:
			instance=preload("res://Assets/PlayebaleTanks/TankR.tscn")
			pass
		1:
			instance=preload("res://Assets/PlayebaleTanks/TankG.tscn")
			pass
		2:
			instance=preload("res://Assets/PlayebaleTanks/TankB.tscn")
			pass
		3:
			instance=preload("res://Assets/PlayebaleTanks/TankY.tscn")
			pass
		4:
			instance=preload("res://Assets/Blocks/Concreete.tscn")
			pass
		5:
			instance=preload("res://Assets/Blocks/Water.tscn")
			pass
		6:
			instance=preload("res://Assets/Blocks/Field.tscn")
			pass
		7:
			instance=preload("res://Assets/Blocks/Bush.tscn")
			pass
		8:
			instance=preload("res://Assets/Blocks/Brick/Brick1.tscn")
			pass
		9:
			instance=preload("res://Assets/Blocks/Brick/Brick2.tscn")
			pass
		10:
			instance=preload("res://Assets/Blocks/Brick/Brick3.tscn")
			pass
		11:
			instance=preload("res://Assets/Blocks/Base.tscn")
			pass
		12:
			instance=preload("res://Assets/Blocks/Crate.tscn")
			pass
		13:
			instance=preload("res://Assets/Bulets/Bulet.tscn")
			pass
		14:
			instance=preload("res://Assets/Bulets/Rocket.tscn")
			size=10
			pass
		15:
			instance=preload("res://Assets/Effects/LaserBeam.tscn")
			pass
		16:
			instance=preload("res://Assets/Bulets/ArtillaryBulet.tscn")
			size=2
			pass
		17:
			instance=preload("res://Assets/Effects/Explode.tscn")
			pass
		18:
			instance=preload("res://Assets/Items/Shield.tscn")
			pass
		19:
			instance=preload("res://Assets/Items/Boost.tscn")
			pass
		20:
			instance=preload("res://Assets/Items/Mine.tscn")
			pass
		21:
			instance=preload("res://Assets/Items/SuperCharge.tscn")
			pass
		22:
			instance=preload("res://Assets/Items/Gunpick.tscn")
			pass
		23:
			instance=preload("res://Assets/Items/RocketPick.tscn")
			pass
		24:
			instance=preload("res://Assets/Items/LaserPick.tscn")
			pass
		25:
			instance=preload("res://Assets/Items/ARTPick.tscn")
			pass
		26:
			instance=preload("res://Assets/Effects/MiniExplode.tscn")
			pass
		27:
			instance=preload("res://Assets/Effects/Plasma.tscn")
			pass
		28:
			instance=preload("res://Assets/Effects/OmenCanon.tscn")
			pass
		29:
			instance=preload("res://Assets/Bulets/Bulet.tscn")
			size=10
			pass
		30:
			instance=preload("res://Assets/Effects/Mafia.tscn")
			size=1
			pass
		31:
			instance=preload("res://Assets/Items/RandomBlock.tscn")
			
			pass
	var new_obj=instance.instantiate()
	new_obj.name=name
	new_obj.position=pos
	new_obj.rotation=rot
	new_obj.scale.x=size
	new_obj.scale.y=size
	NodeManager.GameplayNode.add_child(new_obj)

func _set_bloc(x:int, y:int, sender:Node, meta:int=-1):
	if(!meta_request):
		NodeManager.UInode.remove_child(sender)
		rpc_id(1, "_target_send", x, y, meta)
	else:
		if(stored_meta!=-1):
			NodeManager.UInode.remove_child(sender)
			rpc_id(1, "_target_send", x, y, stored_meta)

@rpc("any_peer")
func _target_req(need_meta:bool):
	NodeManager._targeting()
	meta_request=need_meta
	pass

@rpc("any_peer")
func _client_despawn(name:String):
	print(name)
	for i in NodeManager.GameplayNode.get_children():
		if i.name==name:
			NodeManager.GameplayNode.remove_child(i)

@rpc("any_peer")
func  _changeBlock(name:String, type:int, new_name:String):
	print(name)
	for i in NodeManager.GameplayNode.get_children():
		if(i.name==name):
			var pos=i.position
			NodeManager.GameplayNode.remove_child(i)
			if(type>0):
				_client_spawn(type, new_name, pos)

func _build_mode():
	if(connected):
		rpc_id(1, "_build_pressed")

func _pew():
	if(connected):
		rpc_id(1, "_Shoot_pressed")

func _PU_use():
	if(connected):
		rpc_id(1, "_PU_pressed")

@rpc("any_peer","unreliable")
func _call_move(dir:int):
	pass

@rpc("any_peer")
func _Shoot_pressed():
	pass

@rpc("any_peer")
func _PU_pressed():
	pass

@rpc("any_peer")
func _setName(name:String):
	pass

@rpc("any_peer")
func _target_send(x:int, y:int, meta:int=-1):
	pass
@rpc("any_peer")
func _build_pressed():
	pass
