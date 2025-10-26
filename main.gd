extends Node

var current_room = null
@onready var output_box = $VBoxContainer/Output
@onready var user_input_box = $VBoxContainer/HBoxContainer/UserInput
var ignore_words = ["the", "to"]

# Called when the node enters the scene tree for the first time.
func _ready():
	current_room = load("res://test_room.tres")
	output_box.text = describe_room()


func describe_room() -> String:
	var d = "***" + current_room.name + "***\n" + current_room.get_description()
	d += "\nNearby rooms:\n"
	for r in current_room.adjacent_rooms:
		d += load(r).name + "\n"
	return d
	
func submit(i: String):
	var input = sanitize(i)
	var output = ""
	user_input_box.text = ""
	if(input.begins_with("go ")):
		var loc = input.get_slice("go ", 1)
		if(current_room.is_room_nearby(loc)):
			current_room = current_room.get_nearby_room(loc)
			output = describe_room()
		else:
			output = "Where's that?"
	else:
		output = "I don't know what you mean."
	
	output_box.text += "\n>>>" + i + "\n" + output + "\n"
	var bar : HScrollBar = output_box.get_h_scroll_bar()
	bar.set_value_no_signal(bar.max_value)

func _on_submit_pressed():
	submit(user_input_box.text)


func _on_user_input_text_submitted(new_text):
	submit(new_text)

func sanitize(i:String) -> String:
	var new = i
	new = new.to_lower()
	for word in ignore_words:
		new = "".join(new.split(word))
		new = " ".join(new.split("  "))
	new = new.strip_edges()
	print("-"+new+"-")
	return new
	
