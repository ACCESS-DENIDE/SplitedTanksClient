extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".play("Shoot")
	pass # Replace with function body.



func _on_animation_finished():
	get_parent().remove_child(self)
	queue_free()
	pass # Replace with function body.
