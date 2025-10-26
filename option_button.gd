extends Button

@export var link : Link

signal option_selected(card: DisplayCard)

func _ready():
	text = link.description


func _on_pressed():
	print_debug("pressed")
	option_selected.emit(load(link.destination))
