extends GraphNode

@export var card_title : String
@export var description : String
@export var options : Array[Link]
var path : String

signal option_removed(slot:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	title = name
	$Title.text = card_title
	$Description.text = description
	for i in options:
		var option = add_option()
		option.get_node("Text").text = i.description
	update_ports()

func _on_title_text_changed(new_text):
	title = new_text

func get_port_number(card_path:String):
	var counter = 0
	for i in options:
		if(i.destination == card_path):
			return counter
	return -1

func update_ports():
	var num = 4
	for i in range(num, get_children().size()):
		set_slot_enabled_right(i, true)


func _on_add_option_pressed():
	add_option()
	
func add_option() -> Node:
	var new_option = load("res://visual_editor/option_field.tscn").instantiate()
	new_option.removed.connect(remove_slot.bind(new_option))
	new_option.slot = get_output_port_count()
	add_child(new_option)
	set_slot_enabled_right(get_children().size()-1, true)
	return new_option

func remove_slot(slot: Node):
	option_removed.emit(slot.slot)
	set_slot_enabled_right(get_output_port_count()-1, false)
	slot.queue_free()
