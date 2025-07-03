extends Node2D

var deckPlace := 0
var value := 0
var up := false
var stickers := []

var fliptime := 0.5

var symbol
var card

func _ready() -> void:
	symbol = $symbol
	card = $card
	
	symbol.frame = value
	symbol.visible = false
	card.frame = 1+GameData.deckColor
	
	for i in len(stickers):
		$stickers.get_child(i).visible = true
		$stickers.get_child(i).frame = stickers[i]

func _process(_delta: float) -> void:
	pass

func flip() -> void:
	var tween = get_tree().create_tween()
	var initScale := scale
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self,"scale",Vector2(0,initScale.y),fliptime)
	setCard()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self,"scale",initScale,fliptime)
	up = !up
	$card/Button.disabled = up

func cardClicked() -> void:
	if up or get_parent().checking: return
	get_parent().selected = self
	flip()
	await get_tree().create_timer(fliptime*2).timeout
	
func setCard() -> void:
	await get_tree().create_timer(fliptime).timeout
	symbol.visible = up
	card.frame = 0 if up else 1+GameData.deckColor
	
func showCard() -> void:
	symbol.frame = value
	symbol.visible = true
	card.frame = 0
	
	for i in len(stickers):
		$stickers.get_child(i).visible = true
		$stickers.get_child(i).frame = stickers[i]
