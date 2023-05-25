extends Control



func _ready():
	position=Vector2(-1910, -1030)

func _on_menu_pressed():
	NodeManager._main_menu()

func _load_data(data):
	match data["Powerup"]:
		18:
			$PowerUp.frame=6
		19:
			$PowerUp.frame=4
		20:
			$PowerUp.frame=1
		21:
			$PowerUp.frame=0
		22:
			$PowerUp.frame=7
		23:
			$PowerUp.frame=3
		24:
			$PowerUp.frame=5
		25:
			$PowerUp.frame=2
		31:
			$PowerUp.frame=9
		-1:
			$PowerUp.frame=8
	var BL:ItemList=$MyBlocks
	BL.clear()
	for i in data["Blocks"].keys():
		
		BL.add_item(i+" ("+str(data["Blocks"][i])+")")
		


func _on_my_blocks_item_selected(index):
	Server.stored_meta=index
