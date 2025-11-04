extends Button

@export var link : Link

signal variables_set(link: Link)
signal option_selected(card: DisplayCard)

func _ready():
	text = link.description

func _on_pressed():
	print_debug("pressed")
	variables_set.emit(link)
	option_selected.emit(load(link.destination))
