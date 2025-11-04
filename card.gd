extends Control

@onready var title = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Title
@onready var description = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Description
@onready var options = $PanelContainer/MarginContainer/HBoxContainer/VBoxContainer/Options
var vars = {"cool": 0, "nice": "yeah", "sit": false}
var test = 5

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
		var condition = link.condition
		if(!condition.is_empty()):
			var e = Expression.new()
			e.parse(condition, vars.keys())
			if(not e.has_execute_failed() && !e.execute(vars.values())):
				continue
		var button = load("res://option_button.tscn").instantiate()
		button.link = link
		button.option_selected.connect(set_display)
		button.variables_set.connect(set_variables)
		options.add_child(button)


func set_variables(link: Link):
	for v in link.set_vars:
		var val = v.value
		match v.operator:
			0:
				vars[v.var_name] = val
			6:
				vars[v.var_name] += val
			7:
				vars[v.var_name] -= val


func remove_options():
	for c in options.get_children():
		options.remove_child(c)


func _on_quit_pressed():
	queue_free()
