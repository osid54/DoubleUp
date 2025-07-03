extends Control

var numItems := 3
var options := []

@onready var shopcard := preload("res://assets/ui/ShopCard.tscn")

func _ready() -> void:
	generateItems()

func generateItems() -> void:
	var numGen = randf() #50% 3 items - 20% 2 items - 20% 4 items - 10% 5 items
	if numGen < .5: numItems = 3
	elif numGen < .7: numItems = 2
	elif numGen < .9: numItems = 4
	else: numItems = 5
	
	for i in numItems:
		var itemGen = randf() #50% 2 new cards - 20% 1 dupe card - 20% 1 sticker - 10% 2 stickers
		if itemGen < .5: options.append(0)
		elif itemGen < .7: options.append(1)
		elif itemGen < .9: options.append(2)
		else: options.append(3)
	
	for opt in options:
		var s = shopcard.instantiate()
		s.itemValue = opt
		$hbox.add_child(s)
		
func selected(items : Array) -> void:
	var type = items[0]
	items.erase(type)
	for item in items:
		if type == "Card":
			GameData.deck.append([item,[]])
		if type == "Sticker":
			pass

var board := []
@onready var cardObject := preload("res://assets/objects/Card.tscn")
var fliptime := 0.5

func boardFromData() -> void:
	var size = len(GameData.deck)
	var tempDeck = range(size)
	for i in size:
		var spot : int = tempDeck.pick_random()
		tempDeck.erase(spot)
		var card = GameData.deck[spot]
		var c = cardObject.instantiate()
		c.value = card[0]
		c.stickers = card[1]
		c.deckPlace = spot
		add_child(c)
		board.append(c)

func organizeBoard() -> void:
	var startingPos := get_window().size/2 
	
	var size := len(board)
	var dim := Vector2i()
	if size <= 16:
		dim.x = 4
		dim.y = 4
	elif size <= 24:
		dim.x = 6
		dim.y = 4
	elif size <= 40: 
		dim.x = 8
		dim.y = 5
	else:
		dim.x = 10
		dim.y = 6
	for i in dim.y:
		for j in dim.x:
			if i*dim.x+j < len(board):
				board[i*dim.x+j].position = Vector2(j*50, i*70)
	position.x = startingPos.x + dim.x/2.0 * -50
	position.y = startingPos.y + dim.y/2.0 * -70
