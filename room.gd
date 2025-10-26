extends Describable
class_name Room

@export var adjacent_rooms : Array[String]
@export var items : Array[Item]

func is_room_nearby(room:String) -> bool:
	for r in adjacent_rooms:
		print("-"+room.to_lower() + ", " + load(r).name.to_lower())
		if(room.to_lower() == load(r).name.to_lower()):
			return true
	return false

func get_nearby_room(room:String) -> Room:
	for r in adjacent_rooms:
		if(room.to_lower() == load(r).name.to_lower()):
			return load(r)
	return null
