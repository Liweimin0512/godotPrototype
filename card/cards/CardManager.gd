extends Control

export(float) var offset_x_proportion = 0.2
export(float) var rotation_proportion = 10
export(float) var tween_speed = 0.2

onready var t_card = preload("res://cards/card.tscn")

onready var hand_card = $hand_card
onready var deck = $deck
onready var card_preview = $card_preview
onready var tween = $Tween

var cards = []
var card_amount : int = 0
var offset_x

var dragging = false
var click_pisition

# Called when the node enters the scene tree for the first time.
func _ready():
	card_preview.rect_pivot_offset = Vector2(card_preview.rect_size.x/2,card_preview.rect_size.y)
	card_preview.hide()
	update_card_position()

func _process(delta):
	if dragging:
		_on_card_dragging(cards[1])

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if not dragging and event.pressed:
			dragging = true
			click_pisition =  event.position
		# Stop dragging if the button is released.
		if dragging and not event.pressed:
			dragging = false
			update_card_position()
			

func update_card_position():
	cards = hand_card.get_children()
	if cards.size() == 0:
		return
	card_amount = cards.size()
	offset_x = cards[0].rect_min_size.x
	for i in range(0, card_amount):
		var card_offset = card_amount * -0.5 + 0.5 + 1* i
		cards[i].rect_pivot_offset = Vector2(cards[i].rect_size.x/2,cards[i].rect_size.y)		
		# 位置偏移
		# cards[i].rect_position.x = card_offset * offset_x * offset_x_proportion
		# 旋转偏移
		# cards[i].rect_rotation = card_offset * rotation_proportion
		var target_position = Vector2(card_offset * offset_x * offset_x_proportion , 0)
		var target_rotation = card_offset * rotation_proportion
		var target_scale = Vector2(1,1)

		tween.interpolate_property(cards[i],"rect_position",cards[i].rect_position,target_position,tween_speed,Tween.TRANS_BACK,Tween.EASE_IN)
		tween.interpolate_property(cards[i],"rect_rotation",cards[i].rect_rotation,target_rotation,tween_speed,Tween.TRANS_BACK,Tween.EASE_IN)
		tween.interpolate_property(cards[i],"rect_scale",cards[i].rect_scale,target_scale,tween_speed,Tween.TRANS_BACK,Tween.EASE_IN)
		tween.start()

func add_card(pos:Vector2):
	if tween.is_active():
		return
	var card = t_card.instance()
	hand_card.add_child(card)
	cards.append(card)
	card.rect_scale = Vector2(0,0)
	card.rect_position = pos - hand_card.rect_position
	update_card_position()

func remove_card(card):
	if cards.size() == 0:
		return
	cards.erase(card)
	hand_card.remove_child(card)
	update_card_position()

func get_card_position(card_index : int) -> Vector2:
	card_amount = cards.size()
	var card_offset = card_amount * -0.5 + 0.5 + 1* card_index
	cards[card_index].rect_pivot_offset.x = cards[card_index].rect_min_size.x/2
	cards[card_index].rect_pivot_offset.y = cards[card_index].rect_min_size.y
	
	# 位置偏移
	cards[card_index].rect_position.x = card_offset * offset_x * offset_x_proportion
	# 旋转偏移
	cards[card_index].rect_rotation = card_offset * rotation_proportion
	
	return Vector2(0,0)

###################### 回调函数 ###################

func _on_card_preview(card):
	if tween.is_active():
		return
	var preview_position = card_preview.rect_position - hand_card.rect_position
	tween.interpolate_property(card,"rect_position",
		card.rect_position, preview_position,tween_speed,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.interpolate_property(card,"rect_rotation",
		card.rect_rotation,card_preview.rect_rotation,tween_speed,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.interpolate_property(card,"rect_scale",
		card.rect_scale,card_preview.rect_scale,tween_speed,Tween.TRANS_BACK,Tween.EASE_IN)
	tween.start()

func _on_card_dragging(card):
	card.rect_rotation = 0
	card.rect_scale = Vector2(1.2,1.2)
	card.rect_position = get_viewport().get_mouse_position() - hand_card.rect_position

func _on_btn_add_card_pressed():
	add_card(deck.position)

func _on_btn_remove_card_pressed():
	remove_card(cards[1])

func _on_btn_preview_pressed():
	_on_card_preview(cards[2])
