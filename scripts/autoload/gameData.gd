extends Node

var deck := []
var deckColor := 0

@onready var cardObject := preload("res://assets/objects/Card.tscn")

func _ready() -> void:
	deckColor = 0 #randi_range(0,1)
	for i in 4:
		var c = randi_range(0,17)
		deck.append([c,[]])
		deck.append([c,[]])

func getDeckCards(used := true) -> Array:
	var nums := [] if used else range(0,17)
	for card in deck:
		if used:
			nums.append(card[0])
		else:
			if nums.find(card[0]): nums.erase(card[0])
	return nums
