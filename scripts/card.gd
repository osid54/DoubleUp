extends Node2D

var value := 0
var up := false

var fliptime := 0.5

var fruit
var card

func _ready() -> void:
	fruit = $fruit
	card = $card
	
	fruit.frame = value
	fruit.visible = false
	card.frame = 1+GameData.deckColor

func _process(_delta: float) -> void:
	pass

func flip() -> void:
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self,"scale",Vector2(0,1),fliptime)
	setCard()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.tween_property(self,"scale",Vector2(1,1),fliptime)
	up = !up
	$card/Button.disabled = up

func cardClicked() -> void:
	if up: return
	flip()
	await get_tree().create_timer(fliptime*2).timeout
	get_parent().selected = self
	
func setCard() -> void:
	await get_tree().create_timer(fliptime).timeout
	fruit.visible = up
	card.frame = 0 if up else 1+GameData.deckColor
