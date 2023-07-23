extends Control


func _set_item(row:int, param:String):
	var Itemname
	var sprite
	var price
	match row:
		0:
			sprite=$Spacer/Item1/Sprite
			price=$Spacer/Item1/Price
			Itemname=$Spacer/Item1/Name
			pass
		1:
			sprite=$Spacer/Item2/Sprite
			price=$Spacer/Item2/Price
			Itemname=$Spacer/Item2/Name
			pass
		2:
			sprite=$Spacer/Item3/Sprite
			price=$Spacer/Item3/Price
			Itemname=$Spacer/Item3/Name
			pass
	
	
	price.text=param.split(":")[1]
	Itemname.text=param.split(":")[0]
	
	match param.split(":")[0]:
			"Shield":
				sprite.frame=6
				pass
			"Boost":
				sprite.frame=4
				pass
			"Mine":
				sprite.frame=1
				pass
			"SuperCharge":
				sprite.frame=0
				pass
			"Bulet":
				sprite.frame=7
				pass
			"Rocket":
				sprite.frame=3
				pass
			"Plasma":
				sprite.frame=5
				pass
			"Mortir":
				sprite.frame=2
				pass
			"RandomBlock":
				sprite.frame=9
				pass
			"Sprinkler":
				sprite.frame=10
				pass
			"TankTrap":
				sprite.frame=11
				pass
			"Portal":
				sprite.frame=12
				pass
			"Invisible":
				sprite.frame=13
				pass
			"Nou":
				sprite.frame=14
				pass
			"Jetpack":
				sprite.frame=15
				pass
			"ScoreSucker":
				sprite.frame=16
				pass
			"Slower":
				sprite.frame=17
				pass
			"4X":
				sprite.frame=18
				pass
			"RandomBullShit":
				sprite.frame=19
				pass
			"Angry Beers":
				sprite.frame=20
				pass
			"Fortnite":
				sprite.frame=21
				pass
	pass


func _on_buy1_pressed():
	Server._buyItem(0)
	pass # Replace with function body.


func _on_buy2_pressed():
	Server._buyItem(1)
	pass # Replace with function body.


func _on_buy3_pressed():
	Server._buyItem(2)
	pass # Replace with function body.
