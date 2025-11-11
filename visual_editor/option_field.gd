extends PanelContainer

signal removed
var current_text = ""
var slot : int
var var_lines = []
var signal_lines = []
var condition : String

@onready var text_line = %Text
@onready var option_manager = $VBoxContainer2/OptionManager
@onready var condition_line = $VBoxContainer2/OptionManager/Condition

func _ready():
	text_line.text = current_text
	condition_line.text = condition

func populate(var_arr: Array[VariableManipulation], sig_arr: Array[String]):
	for v in var_arr:
		var var_line = load("res://visual_editor/var_set.tscn").instantiate()
		var_line.var_name = v.var_name
		var_line.operator = v.operator
		var_line.value = v.value
		var_line.type_name = v.type_name
		var_lines.append(var_line)
		var_line.removed.connect(remove_var_line.bind(var_line))
		option_manager.add_child(var_line)
	for s in sig_arr:
		var signal_line = load("res://visual_editor/signal_set.tscn").instantiate()
		signal_line.signal_body = s
		signal_lines.append(signal_line)
		signal_line.removed.connect(remove_signal_line.bind(signal_line))
		option_manager.add_child(signal_line)

func _on_text_text_changed(new_text):
	current_text = new_text


func _on_x_button_pressed():
	removed.emit()


func _on_toggle_button_pressed():
	$VBoxContainer2/OptionManager.visible = !$VBoxContainer2/OptionManager.visible


func get_variable_manipulations() -> Array[VariableManipulation]:
	var arr : Array[VariableManipulation] = []
	for line in var_lines:
		var v_man : VariableManipulation = VariableManipulation.new()
		v_man.type_name = line.type_name
		v_man.var_name = line.var_name
		v_man.value = line.value
		v_man.operator = line.operator
		arr.append(v_man)
	return arr

func get_signals() -> Array[String]:
	var arr : Array[String] = []
	for line in signal_lines:
		arr.append(line.signal_body)
	return arr

func _on_plus_button_pressed():
	var var_line = load("res://visual_editor/var_set.tscn").instantiate()
	var_lines.append(var_line)
	var_line.removed.connect(remove_var_line.bind(var_line))
	option_manager.add_child(var_line)

func remove_var_line(var_line):
	var_lines.erase(var_line)
	var_line.queue_free()

func remove_signal_line(signal_line):
	signal_lines.erase(signal_line)
	signal_line.queue_free()

func _on_condition_text_changed(new_text):
	condition = new_text


func _on_plus_signal_button_pressed():
	var signal_line = load("res://visual_editor/signal_set.tscn").instantiate()
	signal_lines.append(signal_line)
	signal_line.removed.connect(remove_signal_line.bind(signal_line))
	option_manager.add_child(signal_line)
