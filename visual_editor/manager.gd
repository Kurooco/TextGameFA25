extends Control

@onready var text_game_editor = $VBoxContainer/TextGameEditor


func _on_play_pressed():
	var screen = load("res://card.tscn").instantiate()
	add_child(screen)


func _on_save_pressed():
	text_game_editor.save()
	$VBoxContainer/TopMenu/Play.disabled = true
	$SaveIndicator.show()
	await get_tree().create_timer(2).timeout
	$SaveIndicator.hide()


func _on_add_card_pressed():
	var new_card = load("res://visual_editor/node.tscn").instantiate()
	text_game_editor.add_child(new_card)
	var zoom = text_game_editor.zoom
	new_card.position_offset = text_game_editor.scroll_offset/zoom + Vector2((size.x/2)/zoom, (size.y/2)/zoom)
	text_game_editor.cards.append(new_card)
