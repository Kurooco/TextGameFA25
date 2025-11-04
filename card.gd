extends Control

@onready var title = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Title
@onready var description = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Description
@onready var options = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Options
var vars = {"cool": 5, "nice": "yeah"}
var test = 5

func _ready():
	var e = Expression.new()
	e.parse("vars['nice'] == 'y'", ["vars"])
	if(not e.has_execute_failed()):
		print(e.execute([vars]))
	else:
		print("Something went wrong.")
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
