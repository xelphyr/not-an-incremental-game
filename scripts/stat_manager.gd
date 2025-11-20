extends Node

var _stats : Dictionary[StringName, Stat]= {
	&"growth": preload("res://resources/growth.tres"),
	&"memory": preload("res://resources/memory.tres")
}

func get_stat(stat: StringName) -> Stat: 
	var out = _stats.get(stat)
	if out == null:
		print("Error: stat %s does not exist" % stat)
	return out

func get_value(stat : StringName) -> float: return _stats[stat].get_final()

func _ready() -> void:
	for stat_main in _stats.values():
		for stat_dependency in stat_main.dependency_stats:
			var sd = get_stat(stat_dependency)
			if sd:
				stat_main._dyn_mods.append(sd)
