extends Node

var current_room = null
@onready var output_box = $VBoxContainer/Output
@onready var user_input_box = $VBoxContainer/HBoxContainer/UserInput

# Called when the node enters the scene tree for the first time.
func _ready():
	current_room = load("res://test_room.tres")
	print(current_room)
	#output_box.text = describe_room()


func describe_room() -> String:
	var d = "***" + current_room.name + "***\n" + current_room.get_description()
	d += "\nNearby rooms:\n"
	for r in current_room.adjacent_rooms:
		d += r.name + "\n"
	return d
	
func _on_submit_pressed():
	print(current_room.name)
	return
	var input : String = user_input_box.text
	var output = ""
	user_input_box.text = ""
	if(input.begins_with("go to")):
		var loc = input.split("go to")[0]
		if(current_room.is_room_nearby(loc)):
			current_room = current_room.get_nearby_room(loc)
			output = describe_room()
		else:
			output = "Where's that?"
	else:
		output = "I don't know what you mean."
		
	output_box.text += "\n" + output + "\n"
