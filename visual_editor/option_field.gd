extends PanelContainer

signal removed
var current_text = ""
var slot : int

@onready var text_line = %Text
@onready var option_manager = $VBoxContainer2/OptionManager

func _ready():
	current_text = text_line.text


func _on_text_text_changed(new_text):
	current_text = new_text


func _on_x_button_pressed():
	removed.emit()


func _on_toggle_button_pressed():
	$VBoxContainer2/OptionManager.visible = !$VBoxContainer2/OptionManager.visible


func get_variable_manipulation():
	pass


func _on_plus_button_pressed():
	pass # Replace with function body.
