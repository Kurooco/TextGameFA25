extends GraphNode

@export var card_title : String
@export var description : String
@export var options : Array[Link]
@export var option_fields : Array[Node]
var path : String
var ports = 0

signal option_removed(slot:int)

# Called when the node enters the scene tree for the first time.
func _ready():
	title = name
	$Title.text = card_title
	$Description.text = description
	for i in options:
		var option = add_option()
		option.current_text = i.description
		option.current_text = i.description
		option.condition = i.condition
		add_child(option)
		option.populate(i.set_vars, i.signals)
	update_ports()

func _on_title_text_changed(new_text):
	title = new_text
	card_title = new_text

func get_port_number(d:String):
	var counter = 0
	for i in options:
		if(i.description == d):
			return counter
		counter += 1
	return -1

func get_link_description(port_number:int) -> String:
	return option_fields[port_number].current_text

func get_link_condition(port_number:int) -> String:
	return option_fields[port_number].condition

func get_link_variable_manipulations(port_number:int) -> Array:
	return option_fields[port_number].get_variable_manipulations()

func get_link_signals(port_number:int) -> Array:
	return option_fields[port_number].get_signals()

func update_ports():
	var num = get_children().size() - option_fields.size()
	for i in range(num, get_children().size()):
		set_slot_enabled_right(i, true)


func _on_add_option_pressed():
	add_child(add_option())
	update_ports()
	
func add_option() -> Node:
	var new_option = load("res://visual_editor/option_field.tscn").instantiate()
	new_option.removed.connect(remove_slot.bind(new_option))
	new_option.slot = get_output_port_count()
	option_fields.append(new_option)
	ports += 1
	return new_option

func remove_slot(slot: Node):
	option_removed.emit(slot.slot)
	option_fields.erase(slot)
	set_slot_enabled_right(get_output_port_count()-1, false)
	ports -= 1
	slot.queue_free()


func _on_description_text_changed():
	description = $Description.text
