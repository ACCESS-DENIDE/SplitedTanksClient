extends Node2D

var dir
# Called when the node enters the scene tree for the first time.
func _ready():
	var str_dir=name.split("N")[0]
	str_dir=str_dir.left(str_dir.length()-1)
	str_dir=str_dir.right(str_dir.length()-1)
	dir=Vector2(int(str_dir.split(",")[0]),int(str_dir.split(",")[1]))
	$Lifetime.wait_time=float(name.split("N")[1].replace("A", "."))
	$Lifetime.start()
	if(dir.x>0):
		rotation=(atan(dir.x/dir.y))+3.14/2
	else:
		rotation=(atan(dir.x/dir.y))-3.14/2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position-=dir/($Lifetime.wait_time/delta)
	pass

func _on_lifetime_timeout():
	get_parent().remove_child(self)
	queue_free()
