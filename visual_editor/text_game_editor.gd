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
		node.position_offset = card.position
		node.option_removed.connect(remove_connections_to_port.bind(node.name))
	
	await get_tree().physics_frame
	
	# Connect
	for card in cards:
		for link in card.options:
			for other_card in cards:
				if link.destination == other_card.path:
					var from_port = card.get_port_number(link.description)
					print(str(from_port)+", "+link.description)
					connect_node(card.name, from_port, other_card.name, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_connection_request(from_node, from_port, to_node, to_port):
	connect_node(from_node, from_port, to_node, to_port)

func _on_disconnection_request(from_node, from_port, to_node, to_port):
	disconnect_node(from_node, from_port, to_node, to_port)

func remove_connections_to_port(port: int, node: String):
	for c in connections:
		if(c["from_node"] == node):
			if(c["from_port"] == port):
				disconnect_node(c["from_node"], c["from_port"], c["to_node"], c["to_port"])
			elif(c["from_port"] > port):
				disconnect_node(c["from_node"], c["from_port"], c["to_node"], c["to_port"])
				connect_node(c["from_node"], c["from_port"]-1, c["to_node"], c["to_port"])

func save():
	# example
	"""var c : DisplayCard = DisplayCard.new()
	c.description = "Hi there, folks."
	ResourceSaver.save(c, card_path+"new.tres")"""
	clear_all()
	
	# create resources
	var new_cards = []
	var paths = []
	var ind = 0
	for node in cards:
		var new_card := DisplayCard.new()
		new_card.description = node.description
		new_card.title = node.card_title
		new_card.position = node.position_offset
		new_cards.append(new_card)
		paths.append(card_path+"card"+str(ind)+".tres")
		ind += 1
		
	# get names
	var names = []
	for node in cards:
		names.append(node.name)
	
	# connect
	for connection in connections:
		print(connection)
		var link = Link.new()
		var start_card_ind = names.find(connection["from_node"])
		var end_card_ind = names.find(connection["to_node"])
		link.destination = paths[end_card_ind]
		link.description = cards[start_card_ind].get_link_description(connection["from_port"])
		# Add variable manipulations
		link.set_vars = cards[start_card_ind].get_variable_manipulations(connection["from_port"])
		if(link.description != ""):
			new_cards[start_card_ind].options.append(link)
		
	# save resources
	ind = 0
	for card in new_cards:
		ResourceSaver.save(card, paths[ind])
		ind += 1

func _on_delete_nodes_request(nodes):
	for node_name in nodes:
		for child in get_children():
			if(child.name == node_name):
				var ports = child.ports
				for port in range(ports):
					remove_connections_to_port(0, child.name)
				cards.erase(child)
				child.queue_free()
				return

func clear_all():
	for file in DirAccess.get_files_at(card_path):
		DirAccess.remove_absolute(card_path+file)
