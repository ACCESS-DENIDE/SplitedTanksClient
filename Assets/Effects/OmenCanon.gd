extends AnimatedSprite2D

var cou=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_animation_finished():
	cou+=1
	match cou:
		1:
			$".".play("lastCheck")
			pass
		2:
			$".".play("Engage")
			$LaserEnlarger.visible=true
			$LaserEnlarger.play("Enlarged")
			pass
		3:
			get_parent().remove_child(self)
			pass
