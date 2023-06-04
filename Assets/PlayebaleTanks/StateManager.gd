extends CharacterBody2D

var shield_inst=preload("res://Assets/Effects/Shield.tscn")
var my_shield=null

var jet_inst=preload("res://Assets/Effects/Jet.tscn")
var my_jet=null

func _change_state(state:int):
	match state:
		0:
			$Animation.play("Move")
			pass
		1:
			$Animation.stop()
			pass
		2:
			if(my_shield==null):
				my_shield=shield_inst.instantiate()
				my_shield.play("Shield")
				add_child(my_shield)
			pass
		3:
			if(my_shield!=null):
				remove_child(my_shield)
				my_shield.queue_free()
				my_shield=null
			pass
		4:
			if(my_jet==null):
				my_jet=jet_inst.instantiate()
				my_jet.play("Shield")
				add_child(my_jet)
		5:
			if(my_jet!=null):
				remove_child(my_jet)
				my_jet.queue_free()
				my_jet=null
