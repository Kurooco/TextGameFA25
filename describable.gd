extends Resource
class_name Describable

@export var status : Status
@export var name : String
@export var aliases : Array[String]
@export var default_description : String
@export var alt_descriptions : Dictionary[String, String]

func get_description(override:String = "") -> String:
	if(!override.is_empty()):
		return alt_descriptions[override]
	for s in alt_descriptions:
		if(s in status.stats):
			return alt_descriptions[s]
	return default_description
