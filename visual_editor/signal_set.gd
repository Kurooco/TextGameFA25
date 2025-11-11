extends PanelContainer

var signal_body = ""
@onready var signal_set = $HBoxContainer/SignalSet

signal removed

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_set.text = signal_body


func _on_signal_set_text_changed(new_text):
	signal_body = new_text


func _on_x_button_pressed():
	removed.emit()
