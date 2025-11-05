extends PanelContainer

signal removed
var current_text = ""
var slot : int
var var_lines = []

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


func get_variable_manipulations() -> Array[VariableManipulation]:
	var arr = []
	for line in var_lines:
		var v_man : VariableManipulation = load("res://variable_manipulation.gd")
		v_man.type_name = line.type_name
		v_man.var_name = line.var_name
		v_man.value = line.value
		v_man.operator = line.operator
		arr.append(v_man)
	return arr


func _on_plus_button_pressed():
	var var_line = load("res://visual_editor/var_set.tscn").instantiate()
	var_lines.append(var_line)
	var_line.removed.connect(remove_var_line.bind(var_line))
	option_manager.add_child(var_line)

func remove_var_line(var_line):
	var_lines.erase(var_line)
	var_line.queue_free()
