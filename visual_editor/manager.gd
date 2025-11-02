extends Control

@onready var text_game_editor = $VBoxContainer/TextGameEditor


func _on_play_pressed():
	var screen = load("res://card.tscn").instantiate()
	add_child(screen)


func _on_save_pressed():
	text_game_editor.save()


func _on_add_card_pressed():
	var new_card = load("res://visual_editor/node.tscn").instantiate()
	text_game_editor.add_child(new_card)
	text_game_editor.cards.append(new_card)
