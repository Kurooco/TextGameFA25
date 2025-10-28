extends GraphEdit

var card_path = "res://cards/"
var cards : Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	for file in DirAccess.get_files_at(card_path):
		print(card_path+file)
		var card : DisplayCard = load(card_path+file)
		var node = load("res://visual_editor/node.tscn").instantiate()
		node.card_title = card.title
		node.description = card.description
		node.options = card.options.duplicate()
		node.path = card_path+file
		cards.append(node)
		add_child(node)
		node.option_removed.connect(remove_connections_to_port.bind(node.name))
	
	await get_tree().physics_frame
	# Connect
	for card in cards:
		for link in card.options:
			for other_card in cards:
				if link.destination == other_card.path:
					var from_port = card.get_port_number(link.destination)
					connect_node(card.name, from_port, other_card.name, 0)
					
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node, from_port, to_node, to_port)


func _on_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node, from_port, to_node, to_port)

func remove_connections_to_port(port: int, node: String):
	print("remove: "+node+", "+str(port))
	for c in connections:
		if(c["from_node"] == node):
			if(c["from_port"] == port):
				print_debug("found!")
				disconnect_node(c["from_node"], c["from_port"], c["to_node"], c["to_port"])
			elif(c["from_port"] > port):
				disconnect_node(c["from_node"], c["from_port"], c["to_node"], c["to_port"])
				connect_node(c["from_node"], c["from_port"]-1, c["to_node"], c["to_port"])
	print_debug(connections)

func save():
	# example
	var c : DisplayCard = DisplayCard.new()
	c.description = "Hi there, folks."
	ResourceSaver.save(c, card_path+"new.tres")
	
	# create resources
	var new_cards = []
	for node in cards:
		var new_card := DisplayCard.new()
