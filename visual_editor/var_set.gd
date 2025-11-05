extends PanelContainer

var var_name = ""
var operator : Variant.Operator
var val : Variant
var type_name : Variant.Type

@onready var operator_box = $HBoxContainer/Operator
@onready var type_box = $HBoxContainer/Type

signal removed

func _on_x_button_button_down():
	removed.emit()


func _on_var_text_changed(new_text):
	var_name = new_text


func _on_val_text_changed(new_text):
	val = type_convert(new_text, type_name)


func _on_operator_item_selected(index):
	operator = operator_box.get_item_id(index)


func _on_type_item_selected(index):
	type_name = type_box.get_item_id(index)
	val = type_convert(val, type_name)
