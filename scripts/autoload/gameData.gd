extends Node

var deck := []
var deckColor := 0

@onready var cardObject := preload("res://assets/objects/Card.tscn")

func _ready() -> void:
	deckColor = randi_range(0,7)
	for i in 36:
		var c = cardObject.instantiate()
		c.value = randi_range(0,12)
		deck.append(c)
