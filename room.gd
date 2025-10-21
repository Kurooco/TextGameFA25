extends Describable
class_name Room

## WARNING: DEPENDENCY LOOPS. FIX ASAP.
@export var adjacent_rooms : Array[Room]
@export var items : Array[Item]

func is_room_nearby(room:String) -> bool:
	for r in adjacent_rooms:
		if(room == r.name):
			return true
	return false

func get_nearby_room(room:String) -> Room:
	for r in adjacent_rooms:
		if(room == r.name):
			return r
	return null
