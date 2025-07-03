extends Node2D

var board := []
@onready var cardObject := preload("res://assets/objects/Card.tscn")
var fliptime := 0.5
var cardScale := .25
var cardW := 400 * cardScale
var cardH := 600 * cardScale

var selectReq := 2
var selected = null:
	set(value):
		if len(selectedAll) == selectReq:
			return
		selectedAll.append(value)
		if len(selectedAll) == selectReq:
			checkMatch()
var selectedAll := []
var checking = false

func _ready() -> void:
	boardFromData()
	organizeBoard()

func boardFromData() -> void:
	var size = len(GameData.deck)
	var tempDeck = range(size)
	for i in size:
		var spot : int = tempDeck.pick_random()
		tempDeck.erase(spot)
		var card = GameData.deck[spot]
		var c = cardObject.instantiate()
		c.scale = Vector2(1,1) * cardScale
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
				board[i*dim.x+j].position = Vector2(j*cardW, i*cardH)
	position.x = startingPos.x + dim.x/2.0 * -cardW
	position.y = startingPos.y + size/float(dim.x)/2.0 * -cardH
				
func checkMatch():
	checking = true
	await get_tree().create_timer(fliptime*2).timeout
	var correct = true
	var selectedValue = selectedAll[0].value
	for card in selectedAll:
		if card.value != selectedValue:
			correct = false
			break
	if correct:
		for card in selectedAll:
			var tween = get_tree().create_tween()
			tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
			tween.tween_property(card,"global_position",Vector2(200,200),1)
	else:
		for card in selectedAll:
			card.flip()
	selectedAll.clear()
	checking = false

func _process(_delta: float) -> void:
	pass
	
