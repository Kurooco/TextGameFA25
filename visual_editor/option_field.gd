extends PanelContainer

signal removed
var current_text = ""
var slot : int

@onready var text_line = %Text

func _ready():
	current_text = text_line.text


func _on_text_text_changed(new_text):
	current_text = new_text


func _on_x_button_pressed():
	removed.emit()


func _on_toggle_button_pressed():
	$VBoxContainer2/OptionManager.visible = !$VBoxContainer2/OptionManager.visible
