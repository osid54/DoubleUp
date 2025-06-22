extends Node2D

var board := []
@onready var cardObject := preload("res://assets/objects/Card.tscn")

var selectReq := 2
var selected = null:
	set(value):
		if len(selectedAll) == selectReq:
			return
		selectedAll.append(value)
		if len(selectedAll) == selectReq:
			checkMatch()
		print(selectedAll)
var selectedAll := []


func _ready() -> void:
	boardFromData()
	organizeBoard()

func boardFromData() -> void:
	var size = len(GameData.deck)
	var tempDeck = range(size)
	for i in size:
		var spot : int = tempDeck.pick_random()
		var card = GameData.deck[spot]
		var c = cardObject.instantiate()
		c.value = card.value
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
				
func _process(_delta: float) -> void:
	pass
	
func checkMatch():
	var correct = true
	var selectedValue = selectedAll[0].value
	for card in selectedAll:
		if card.value != selectedValue:
			correct = false
			break
	if correct:
		for card in selectedAll:
			card.global_position = Vector2()
	else:
		for card in selectedAll:
			card.flip()
	selectedAll.clear()
	
