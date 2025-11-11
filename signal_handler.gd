extends Node

signal global_signal(arg: String)
signal global_dict_signal(arg: Dictionary)

func send_global_signal(arg):
	var dict = JSON.parse_string(arg)
	if(dict != null):
		global_dict_signal.emit(dict)
	else:
		global_signal.emit(arg)
