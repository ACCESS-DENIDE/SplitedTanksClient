extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$".".speed_scale=Server.plasma_FPS
	$".".play("Ignition")
	pass # Replace with function body.



func _on_animation_finished():
	$".".play("Charge")
	pass # Replace with function body.
