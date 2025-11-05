extends PanelContainer

var var_name = ""
var operator : Variant.Operator
var value : Variant = ""
var type_name : Variant.Type

var text_value = ""

@onready var operator_box = $HBoxContainer/Operator
@onready var type_box = $HBoxContainer/Type
@onready var var_line = $HBoxContainer/Var
@onready var val_line = $HBoxContainer/Val

signal removed

func _ready():
	var_line.text = var_name
	val_line.text = str(value)
	operator_box.select(operator_box.get_item_index(operator))
	type_box.select(type_box.get_item_index(type_name))

func _on_x_button_button_down():
	removed.emit()


func _on_var_text_changed(new_text):
	var_name = new_text


func _on_val_text_changed(new_text):
	text_value = new_text
	value = type_convert(new_text, type_name)


func _on_operator_item_selected(index):
	operator = operator_box.get_item_id(index)


func _on_type_item_selected(index):
	type_name = type_box.get_item_id(index)
	value = type_convert(text_value, type_name)
