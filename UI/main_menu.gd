extends Control

func _on_start_pressed():
	NodeManager._connection_grid()


func _on_quit_pressed():
	get_tree().quit()


func _on_map_editor_pressed():
	NodeManager._mapEdior()
