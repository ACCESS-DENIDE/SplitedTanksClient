extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".play("Explode")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_animation_finished():
	get_parent().remove_child(self)
