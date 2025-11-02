extends Control

@onready var title = $PanelContainer/MarginContainer/VBoxContainer/Title
@onready var description = $PanelContainer/MarginContainer/VBoxContainer/Description
@onready var options = $PanelContainer/MarginContainer/VBoxContainer/Options

func _ready():
	set_display(load("res://cards/card0.tres"))

func set_display(d : DisplayCard):
	print_debug("reset display")
	if(d.title == ""):
		title.hide()
	else:
		title.show()
		title.text = d.title
	description.text = d.description
	remove_options()
	for link in d.options:
		var button = load("res://option_button.tscn").instantiate()
		button.link = link
		button.option_selected.connect(set_display)
		options.add_child(button)
	
func remove_options():
	for c in options.get_children():
		options.remove_child(c)


func _on_quit_pressed():
	queue_free()
