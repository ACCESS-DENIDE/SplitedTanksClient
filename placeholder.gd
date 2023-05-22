extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().remove_child.call_deferred(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
