extends Control



func _ready():
	position=Vector2(-1910, -1030)

func _on_menu_pressed():
	NodeManager._main_menu()

func _load_data(data):
	if data.has("Powerup"):
		$AudioStreamPlayer2.play()
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
			32:
				$PowerUp.frame=10
			33:
				$PowerUp.frame=11
			34:
				$PowerUp.frame=12
			35:
				$PowerUp.frame=13
			36:
				$PowerUp.frame=14
			37:
				$PowerUp.frame=15
			38:
				$PowerUp.frame=16
			39:
				$PowerUp.frame=17
			40:
				$PowerUp.frame=18
			41:
				$PowerUp.frame=19
			42:
				$PowerUp.frame=20
			43:
				$PowerUp.frame=21
			-1:
				$PowerUp.frame=8
	if(data.has("Blocks")):
		var BL:ItemList=$MyBlocks
		BL.clear()
		for i in data["Blocks"].keys():
			
			BL.add_item(i+" ("+str(data["Blocks"][i])+")")
			
	if(data.has("Scores")):
		var score_list=$Scores
		score_list.clear()
		for i in data["Scores"].keys():
			score_list.add_item(i+" ("+str(data["Scores"][i])+")")
	if(data.has("ShopDeals")):
		for i in range(0, 3):
			match i:
				0:
					$GridContainer/Shop1.text=str(data["ShopDeals"].keys()[i])+ ":"+str(data["ShopDeals"].values()[i])
					pass
				1:
					$GridContainer/Shop2.text=str(data["ShopDeals"].keys()[i])+ ":"+str(data["ShopDeals"].values()[i])
					pass
				2:
					$GridContainer/Shop3.text=str(data["ShopDeals"].keys()[i])+ ":"+str(data["ShopDeals"].values()[i])
					pass
					
			


func _on_my_blocks_item_selected(index):
	Server.stored_meta=index


func _on_buy_1_pressed():
	Server._buyItem(0)
	pass # Replace with function body.


func _on_buy_2_pressed():
	Server._buyItem(1)
	pass # Replace with function body.


func _on_buy_3_pressed():
	Server._buyItem(2)
	pass # Replace with function body.
