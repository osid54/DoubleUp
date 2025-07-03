extends Panel

var itemValue := 0
var titles := ["New Cards", "Extra Card", "Sticker", "Stickers"]
var captions := ["A new pair of cards to try and match up",
				 "Another copy of a card you already have",
				 "Get a helpful effect when a match is made",
				 "Get a helpful effect when a match is made"]
var items := []

func _ready() -> void:
	$vbox/title.text = titles[itemValue]
	$vbox/desc.text = captions[itemValue]
	match itemValue:
		0:
			$vbox/items0.visible = true
			var cardNum = GameData.getDeckCards(false).pick_random()
			$vbox/items0/card1/fruit.frame = cardNum
			$vbox/items0/card2/fruit.frame = cardNum
			items = ["card", cardNum, cardNum]
		1:
			$vbox/items1.visible = true
			var cardNum = GameData.getDeckCards().pick_random()
			$vbox/items1/card/fruit.frame = cardNum
			items = ["card", cardNum]
		2:
			$vbox/items2.visible = true
			var stickerNum = randi_range(0,9)
			$vbox/items2/sticker.frame = stickerNum
			items = ["sticker", stickerNum]
		3:
			$vbox/items3.visible = true
			var stickerNum1 = randi_range(0,9)
			$vbox/items3/sticker1.frame = stickerNum1
			var stickerNum2 = randi_range(0,9)
			$vbox/items3/sticker2.frame = stickerNum2
			items = ["sticker", stickerNum1, stickerNum2]

func selected() -> void:
	get_parent().get_parent().selected(items)
