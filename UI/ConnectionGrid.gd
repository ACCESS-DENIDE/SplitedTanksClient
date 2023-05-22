extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Server._set_response_label($Response)


func _on_back_pressed():
	NodeManager._main_menu()


func _on_connect_pressed():
	Server._connecting($Container/IPBox.text, $Container/PortBox.text, $Container/NameBox.text)

func _exit_tree():
	Server._set_response_label(null)
