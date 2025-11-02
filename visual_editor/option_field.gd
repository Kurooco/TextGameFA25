extends HBoxContainer

signal removed
var current_text = ""
var slot : int

func _ready():
	current_text = $Text.text

func _on_button_pressed():
	removed.emit()


func _on_text_text_changed(new_text):
	current_text = new_text
